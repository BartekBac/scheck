import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/data/datasources/entry_local_data_source.dart';
import 'package:scheck/features/entries/data/datasources/entry_remote_data_source.dart';
import 'package:scheck/features/entries/data/datasources/supabase/entry_change.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

/*
class EntryRepositoryImpl implements EntryRepository {
  final DatabaseHelper _databaseHelper;

  EntryRepositoryImpl(this._databaseHelper);

  @override
  Future<List<Entry>> getEntries() async {
    final entryModels = await _databaseHelper.getEntries();
    return entryModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addEntry(Entry entry) async {
    await _databaseHelper.insertEntry(EntryModel.fromEntity(entry));
  }

  @override
  Future<void> deleteEntry(String id) async {
    await _databaseHelper.deleteEntry(id);
  }
}
*/

@LazySingleton(as: EntryRepository)
class EntryRepositoryImpl implements EntryRepository {
  final EntryLocalDataSource local;
  final EntryRemoteDataSource remote;

  EntryRepositoryImpl(this.local, this.remote) {
    _subscribeToRealtime();
  }

  @override
  Stream<List<Entry>> watchAll() => local.watchAll()
      .map((models) => models.map((model) => model.toEntity()).toList());

  @override
  Future<List<Entry>> getEntries() async {
    final remoteEntries = await remote.fetchAll();
    await local.upsertAll(remoteEntries);
    return remoteEntries.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addEntry(Entry entry) async {
    EntryModel entryModel = EntryModel.fromEntity(entry);
    // optimistic update
    await local.insert(entryModel);

    try {
      await remote.insert(entryModel);
    } catch (e) {
      await local.delete(entryModel.id);
      rethrow;
    }
  }

  @override
  Future<void> deleteEntry(Entry entry) async {
    await local.delete(entry.id);
    try {
      await remote.delete(entry.id);
    } catch (e) {
      await local.insert(EntryModel.fromEntity(entry));
      rethrow;
    }
  }

  void _subscribeToRealtime() {
    remote.watchRealtime().listen((change) async {
      switch (change) {
        case EntryInserted(:final entry):
          await local.insert(entry);
        case EntryUpdated(:final entry):
          await local.insert(entry);
        case EntryDeleted(:final id):
          await local.delete(id);
      }
    });
  }
}
