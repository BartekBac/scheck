import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:scheck/features/entries/data/datasources/entry_local_data_source.dart';
import 'package:scheck/features/entries/data/datasources/sqflite/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

//@LazySingleton(as: EntryLocalDataSource)
class SqfliteEntryLocalDataSource implements EntryLocalDataSource {

  SqfliteEntryLocalDataSource(this.sDb) {
    _emitCurrentState();
  }

  final SqfliteDatabase sDb;

  // PRIVATE
  final _controller = StreamController<List<EntryModel>>.broadcast();

  Future<void> _emitCurrentState() async {
    final db = await sDb.database;
    final List<Map<String, dynamic>> rows = await db.query(
      SqfliteDatabase.entriesTable,
      orderBy: '${SqfliteDatabase.entriesColumnTimestamp} DESC',
    );

    final entries = rows.map(EntryModel.fromMap).toList();
    _controller.add(entries);
  }

  // PUBLIC

  /*
  Future<List<EntryModel>> getEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _entriesTable,
      orderBy: '$_entriesColumnTimestamp DESC',
    );

    return List.generate(maps.length, (i) {
      return EntryModel.fromMap(maps[i]);
    });
  }
  */

  @override
  Future<void> upsertAll(List<EntryModel> entries)  async {
    final batch = (await sDb.database).batch();

    for (final entry in entries) {
      batch.insert(
        SqfliteDatabase.entriesTable,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
    await _emitCurrentState();
  }

  @override
  Stream<List<EntryModel>> watchAll() => _controller.stream;

  @override
  Future<void> insert(EntryModel entry) async {
    final db = await sDb.database;
    await db.insert(
      SqfliteDatabase.entriesTable,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _emitCurrentState();
  }

  @override
  Future<void> delete(String id) async {
    final db = await sDb.database;
    await db.delete(
      SqfliteDatabase.entriesTable,
      where: '${SqfliteDatabase.entriesColumnId} = ?',
      whereArgs: [id],
    );
    await _emitCurrentState();
  }

  Future<void> close() async {
    final db = await sDb.database;
    await db.close();
    await _controller.close();
  }
}