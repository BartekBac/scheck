part of 'entry_bloc.dart';

abstract class EntryEvent {}

class LoadEntries extends EntryEvent {}

class EntriesSubscriptionRequested extends EntryEvent {}

//TOCHECK: Upload/Add events could be removed? or could be replaced by update methods
class UploadImageEvent extends EntryEvent {
  final File image;
  final String userId;
  final String entryId;

  UploadImageEvent(this.image, this.userId, this.entryId);
}

class AddEntryEvent extends EntryEvent {
  final Entry entry;

  AddEntryEvent(this.entry);
}

class DeleteEntryEvent extends EntryEvent {
  final Entry entry;

  DeleteEntryEvent(this.entry);
}