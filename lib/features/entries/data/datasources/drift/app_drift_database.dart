import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheck/features/entries/data/datasources/drift/tables//entries.dart';

part 'app_drift_database.g.dart';

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'app_db.sqlite',
    native: const DriftNativeOptions(
      databaseDirectory: getApplicationDocumentsDirectory,
    ),

    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

@injectable
@DriftDatabase(tables: [Entries])
class AppDriftDatabase extends _$AppDriftDatabase {
  AppDriftDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
