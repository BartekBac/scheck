import 'package:drift/drift.dart';
import 'package:scheck/features/entries/data/datasources/drift/tables//entries.dart';

part 'app_drift_database.g.dart';

@DriftDatabase(tables: [Entries])
class AppDriftDatabase extends _$AppDriftDatabase {
  AppDriftDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
