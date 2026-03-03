import 'dart:io';

import 'package:scheck/core/entities/entry.dart';

abstract class EntryRepository {
  // Query real-time update
  Stream<List<Entry>> watchAll();
  // Query on demand update
  Future<List<Entry>> getEntries();

  // Commands
  Future<void> addEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);

  Future<String> uploadImage(File image, String userId, String entryId);
  Future<void> deleteImage(String userId, String entryId);
}