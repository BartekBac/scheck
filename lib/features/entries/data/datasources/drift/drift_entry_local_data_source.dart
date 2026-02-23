import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/features/entries/data/datasources/drift/app_drift_database.dart';
import 'package:scheck/features/entries/data/datasources/entry_local_data_source.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

@LazySingleton(as: EntryLocalDataSource)
class DriftEntryLocalDataSource implements EntryLocalDataSource {
  DriftEntryLocalDataSource(this.db);
  final AppDriftDatabase db;

  @override
  Stream<List<EntryModel>> watchAll() {
    return (db.select(db.entries)
      ..orderBy([
            (e) => OrderingTerm(
          expression: e.timestamp,
          mode: OrderingMode.desc,
        )
      ]))
        .watch()
        .map(
          (rows) => rows
          .map(
            (row) => EntryModel(
              id: row.id,
              userId: row.userId,
              timestamp: row.timestamp,
              type: row.type,
              data: row.data,
              description: row.description
        ),
      ).toList(),
    );
  }

  @override
  Future<void> upsertAll(List<EntryModel> entries) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        db.entries,
        entries.map(_toCompanion).toList(),
      );
    });
  }

  @override
  Future<void> insert(EntryModel entry) async {
    await db.into(db.entries).insertOnConflictUpdate(
      _toCompanion(entry),
    );
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(db.entries)
      ..where((e) => e.id.equals(id)))
        .go();
  }

  EntriesCompanion _toCompanion(EntryModel e) {
    return EntriesCompanion.insert(
      id: e.id,
      userId: e.userId,
      timestamp: e.timestamp,
      type: e.type,
      data: e.data,
      description: Value(e.description)
    );
  }
}
