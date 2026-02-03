import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

//TODO: to remove, should be replace with EntryLocalDataSourceImpl
class DatabaseHelper {
  static const String _databaseName = 'scheck.db';
  static const int _databaseVersion = 1;

  static const String _entriesTable = 'entries';
  static const String _entriesColumnId = 'id';
  static const String _entriesColumnTimestamp = 'timestamp';
  static const String _entriesColumnType = 'type';
  static const String _entriesColumnData = 'data';
  static const String _entriesColumnDescription = 'description';

  late Database _database;

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_entriesTable (
        $_entriesColumnId TEXT PRIMARY KEY,
        $_entriesColumnTimestamp INTEGER NOT NULL,
        $_entriesColumnType TEXT NOT NULL,
        $_entriesColumnData TEXT NOT NULL,
        $_entriesColumnDescription TEXT
      )
    ''');
  }

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

  Future<void> insertEntry(EntryModel entry) async {
    final db = await database;
    await db.insert(
      _entriesTable,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEntry(String id) async {
    final db = await database;
    await db.delete(
      _entriesTable,
      where: '$_entriesColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}