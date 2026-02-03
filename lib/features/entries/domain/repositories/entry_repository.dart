import 'package:scheck/core/entities/entry.dart';

abstract class EntryRepository {
  // Query real-time update
  Stream<List<Entry>> watchAll();
  // Query on demand update
  //TODO: should be Future<void>
  Future<List<Entry>> getEntries();

  // Commands
  Future<void> addEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);
  //TODO: continue with https://chatgpt.com/c/697e9bbf-083c-832d-bbd6-e492ce60a409
}