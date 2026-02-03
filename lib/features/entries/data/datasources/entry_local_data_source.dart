import 'package:scheck/features/entries/data/models/entry_model.dart';

abstract class EntryLocalDataSource {
  Stream<List<EntryModel>> watchAll();
  Future<void> upsertAll(List<EntryModel> entities);
  Future<void> insert(EntryModel entry);
  Future<void> delete(String id);
}
