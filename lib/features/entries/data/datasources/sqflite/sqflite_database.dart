import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//TODO: zweryfikowac gdzie instancjonowac uzywajac getIt<> i czy zadzialal auto-gen
@LazySingleton()
class SqfliteDatabase {
  SqfliteDatabase() {
    _initDatabase();
  }
  static const String databaseName = 'scheck.db';
  static const int databaseVersion = 1;

  static const String entriesTable = 'entries';
  static const String entriesColumnId = 'id';
  static const String entriesColumnTimestamp = 'timestamp';
  static const String entriesColumnType = 'type';
  static const String entriesColumnData = 'data';
  static const String entriesColumnDescription = 'description';

  Database? _database;

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $entriesTable (
        $entriesColumnId TEXT PRIMARY KEY,
        $entriesColumnTimestamp INTEGER NOT NULL,
        $entriesColumnType TEXT NOT NULL,
        $entriesColumnData TEXT NOT NULL,
        $entriesColumnDescription TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }
}