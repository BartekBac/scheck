import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/core/utils/message_facade.dart';
import 'package:scheck/features/entries/domain/usecases/add_entry.dart';
import 'package:scheck/features/entries/domain/usecases/delete_entry.dart';
import 'package:scheck/features/entries/domain/usecases/get_entries.dart';
import 'package:scheck/features/entries/domain/usecases/watch_entries.dart';
import 'dart:developer' as developer;

part 'entry_event.dart';
part 'entry_state.dart';
part 'entry_bloc.freezed.dart';


@injectable
class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final GetEntries getEntries;
  final AddEntry addEntry;
  final DeleteEntry deleteEntry;
  final WatchEntries watchEntries;

  EntryBloc({
    required this.getEntries,
    required this.addEntry,
    required this.deleteEntry,
    required this.watchEntries,
  }) : super(EntryInitial()) {
    on<LoadEntries>(_onLoadEntries);
    on<AddEntryEvent>(_onAddEntry);
    on<DeleteEntryEvent>(_onDeleteEntry);
    on<EntriesSubscriptionRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(
      EntriesSubscriptionRequested event,
      Emitter<EntryState> emit,
      ) async {
    emit(EntryLoading());
    await emit.onEach<List<Entry>>(
      watchEntries(),
      onData: (entries) => emit(EntryLoaded(entries)),
      onError: (error, stackTrace) {
        developer.log('Failed to load entries.', error: error, stackTrace: stackTrace);
        emit(const EntryError(MessageFacade.loadEntriesError));
      },
    );
  }

  Future<void> _onLoadEntries(LoadEntries event, Emitter<EntryState> emit) async {
    emit(EntryLoading());
    try {
      final entries = await getEntries();
      emit(EntryLoaded(entries));
    } catch (e) {
      developer.log('Failed to load entries.', error: e);
      emit(const EntryError(MessageFacade.loadEntriesError));
    }
  }


  Future<void> _onAddEntry(AddEntryEvent event, Emitter<EntryState> emit) async {
    try {
      await addEntry.call(event.entry);
    } catch (e) {
      developer.log('Failed to add entry.', error: e);
      emit(const EntryError(MessageFacade.addEntryError));
    }
  }

  Future<void> _onDeleteEntry(DeleteEntryEvent event, Emitter<EntryState> emit) async {
    try {
      await deleteEntry.call(event.entry);
    } catch (e) {
      developer.log('Failed to delete entry.', error: e);
      emit(const EntryError(MessageFacade.deleteEntryError));
    }
  }

}