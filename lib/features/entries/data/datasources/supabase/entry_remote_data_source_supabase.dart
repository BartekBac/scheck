import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:scheck/core/services/image_service.dart';
import 'package:scheck/features/entries/data/datasources/entry_remote_data_source.dart';
import 'package:scheck/features/entries/data/datasources/supabase/entry_change.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: EntryRemoteDataSource)
class EntryRemoteDataSourceSupabase implements EntryRemoteDataSource {
  final SupabaseClient _client;
  final String _tableName = ImageService.tableName;
  final String _bucketName = ImageService.bucketName;
  final StreamController<EntryChange> _controller = StreamController<EntryChange>.broadcast();
  static String imageStoragePath(String bucketName, String userId, String entryId) => '$bucketName/$userId/$entryId.jpg';

  EntryRemoteDataSourceSupabase(this._client) {
    _setupRealtimeSubscription();
  }

  void _setupRealtimeSubscription() {
    _client.channel(_tableName).onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: _tableName,
      callback: (payload) {
        final currentUser = _client.auth.currentUser;
        if (currentUser == null) return;
        
        final record = payload.eventType == PostgresChangeEvent.delete 
            ? payload.oldRecord 
            : payload.newRecord;
            
        final recordUserId = record['user_id'] as String?;
        if (recordUserId != currentUser.id) return;
        
        switch (payload.eventType) {
          case PostgresChangeEvent.insert:
            final entry = EntryModel.fromMap(payload.newRecord);
            _controller.add(EntryInserted(entry: entry));
            break;
          case PostgresChangeEvent.update:
            final entry = EntryModel.fromMap(payload.newRecord);
            _controller.add(EntryUpdated(entry: entry));
            break;
          case PostgresChangeEvent.delete:
            final id = payload.oldRecord['id'] as String;
            _controller.add(EntryDeleted(id: id));
            break;
          case PostgresChangeEvent.all:
            throw Exception("Unexpected PostgresChangeEvent type: ${payload.eventType.toString()}");
        }
      },
    ).subscribe();
  }

  @override
  Future<List<EntryModel>> fetchAll() async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }
      
      final response = await _client
          .from(_tableName)
          .select()
          .eq('user_id', currentUser.id)
          .order('timestamp', ascending: false);

      return (response as List<dynamic>)
          .map((json) => EntryModel.fromMap(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch entries: $e');
    }
  }

  @override
  Future<String> uploadImage(File image, String userId, String entryId) async {
    final String storagePath = imageStoragePath(_bucketName, userId, entryId);

    try {
      await _client.storage
          .from(_bucketName)
          .upload(storagePath, image);

      final String publicUrl = _client.storage
          .from(_bucketName)
          .getPublicUrl(storagePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  @override
  Future<void> deleteImage(String userId, String entryId) async {
    final String storagePath = imageStoragePath(_bucketName, userId, entryId);

    try {
      await _client.storage
          .from(_bucketName)
          .remove([storagePath]);

    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }

  @override
  Future<void> insert(EntryModel entry) async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null || currentUser.id != entry.userId) {
        throw Exception('User not authenticated');
      }

      await _client.from(_tableName).insert(entry.toMap());
    } catch (e) {
      throw Exception('Failed to insert entry: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      //delete row from table
      await _client
          .from(_tableName)
          .delete()
          .eq('id', id)
          .eq('user_id', currentUser.id);
    } catch (e) {
      throw Exception('Failed to delete entry: $e');
    }
  }

  @override
  Stream<EntryChange> watchRealtime() {
    return _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}
