import 'package:scheck/features/entries/data/datasources/isar/collections/entry_collection.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

extension EntryCollectionMapper on EntryCollection {
  EntryModel toModel() => EntryModel(
    id: entryId,
    userId: userId,
    timestamp: timestamp,
    type: type,
    data: data,
    description: description
  );
}

EntryCollection toCollection(EntryModel e) {
  return EntryCollection()
    ..entryId = e.id
    ..userId = e.userId
    ..timestamp = e.timestamp
    ..type = e.type
    ..data = e.data
    ..description = e.description;
}
