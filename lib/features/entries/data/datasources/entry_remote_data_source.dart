import 'package:scheck/features/entries/data/datasources/supabase/entry_change.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

abstract class EntryRemoteDataSource {
  Future<List<EntryModel>> fetchAll();
  Future<void> insert(EntryModel entry);
  Future<void> delete(String id);
  Stream<EntryChange> watchRealtime();
}
