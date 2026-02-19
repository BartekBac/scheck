import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:scheck/features/entries/data/datasources/entry_remote_data_source.dart';
import 'package:scheck/features/entries/data/datasources/supabase/entry_change.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: EntryRemoteDataSource)
class EntryRemoteDataSourceSupabase implements EntryRemoteDataSource {
  final SupabaseClient _client;
  final StreamController<EntryChange> _controller = StreamController<EntryChange>.broadcast();
  static const String _tableName = 'entries';

  EntryRemoteDataSourceSupabase(this._client) {
    _setupRealtimeSubscription();
  }

  void _setupRealtimeSubscription() {
    _client.channel(_tableName).onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: _tableName,
      callback: (payload) {
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
      final response = await _client
          .from(_tableName)
          .select()
          .order('timestamp', ascending: false);

      return (response as List<dynamic>)
          .map((json) => EntryModel.fromMap(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch entries: $e');
    }
  }

  @override
  Future<void> insert(EntryModel entry) async {
    try {
      await _client.from(_tableName).insert(entry.toMap());
    } catch (e) {
      throw Exception('Failed to insert entry: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id);
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
