import 'package:drift/drift.dart';

class Entries extends Table {
  TextColumn get id => text()();
  IntColumn get timestamp => integer()();
  TextColumn get type => text()();
  TextColumn get data => text()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
