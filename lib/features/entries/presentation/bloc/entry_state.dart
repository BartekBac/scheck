part of 'entry_bloc.dart';

abstract class EntryState {}

class EntryInitial extends EntryState {}

class EntryLoading extends EntryState {}

class EntryLoaded extends EntryState {
  final List<Entry> entries;

  EntryLoaded(this.entries);
}

class EntryError extends EntryState {
  final String message;

  EntryError(this.message);
}