import 'package:isar/isar.dart';

@collection
class EntryCollection {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String entryId;
  @Index()
  late String userId;
  late int timestamp;
  late String type;
  late String data;
  late String? description;
}
