import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/usecases/add_entry.dart';
import 'package:scheck/features/entries/domain/usecases/get_entries.dart';
//import 'entry_event.dart';
//import 'entry_state.dart';

part 'entry_event.dart';
part 'entry_state.dart';

//TODO: should be refactored to watch repo streams
@injectable
class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final GetEntries getEntries;
  final AddEntry addEntry;

  EntryBloc({
    required this.getEntries,
    required this.addEntry,
  }) : super(EntryInitial()) {
    on<LoadEntries>(_onLoadEntries);
    on<AddEntryEvent>(_onAddEntry);
    on<DeleteEntryEvent>(_onDeleteEntry);
  }

  Future<void> _onLoadEntries(LoadEntries event, Emitter<EntryState> emit) async {
    emit(EntryLoading());
    try {
      final entries = await getEntries();
      emit(EntryLoaded(entries));
    } catch (e) {
      emit(EntryError('Failed to load entries: $e'));
    }
  }

  Future<void> _onAddEntry(AddEntryEvent event, Emitter<EntryState> emit) async {
    try {
      await addEntry(event.entry);
      add(LoadEntries());
    } catch (e) {
      emit(EntryError('Failed to add entry: $e'));
    }
  }

  Future<void> _onDeleteEntry(DeleteEntryEvent event, Emitter<EntryState> emit) async {
    try {
      await Future.delayed(Duration.zero); // TODO: Implement delete
      add(LoadEntries());
    } catch (e) {
      emit(EntryError('Failed to delete entry: $e'));
    }
  }
}