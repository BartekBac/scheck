part of 'entry_bloc.dart';

abstract class EntryEvent {}

class LoadEntries extends EntryEvent {}

class EntriesSubscriptionRequested extends EntryEvent {}

/*
class AddEntryEvent extends EntryEvent {
  final Entry entry;

  AddEntryEvent(this.entry);
}

class DeleteEntryEvent extends EntryEvent {
  final String id;

  DeleteEntryEvent(this.id);
}*/