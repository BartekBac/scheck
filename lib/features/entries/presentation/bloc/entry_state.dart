part of 'entry_bloc.dart';

@freezed
sealed class EntryState with _$EntryState {
  const factory EntryState.initial() = EntryInitial;
  const factory EntryState.loading() = EntryLoading;
  const factory EntryState.loaded(List<Entry> entries) = EntryLoaded;
  const factory EntryState.error(MessageFacade error) = EntryError;
}
