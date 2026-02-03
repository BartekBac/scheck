import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/usecases/add_entry.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/features/entries/presentation/widgets/symptom_registration_form.dart';
import 'package:scheck/injection.dart';

class SymptomRegistrationPage extends StatelessWidget {
  const SymptomRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Symptoms'),
        elevation: 0,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => getIt<SymptomRegistrationBloc>(),
        child: const SymptomRegistrationForm(),
      ),
    );
  }
}

@injectable
class SymptomRegistrationBloc extends Bloc<SymptomRegistrationEvent, SymptomRegistrationState> {
  final AddEntry addEntry;

  SymptomRegistrationBloc({required this.addEntry})
      : super(const SymptomRegistrationState()) {
    on<SelectSymptoms>(_onSelectSymptoms);
    on<UpdateSymptomIntensity>(_onUpdateSymptomIntensity);
    on<UpdateDescription>(_onUpdateDescription);
    on<SubmitSymptoms>(_onSubmitSymptoms);
  }

  Future<void> _onSelectSymptoms(SelectSymptoms event, Emitter<SymptomRegistrationState> emit) async {
    final selectedSymptoms = List<String>.from(state.selectedSymptoms);
    if (selectedSymptoms.contains(event.symptom)) {
      selectedSymptoms.remove(event.symptom);
      state.symptomIntensities.remove(event.symptom);
    } else {
      selectedSymptoms.add(event.symptom);
      state.symptomIntensities[event.symptom] = 1;
    }
    
    emit(state.copyWith(
      selectedSymptoms: selectedSymptoms,
      status: selectedSymptoms.isEmpty 
          ? SymptomRegistrationStatus.initial
          : SymptomRegistrationStatus.symptomsSelected,
    ));
  }

  Future<void> _onUpdateSymptomIntensity(UpdateSymptomIntensity event, Emitter<SymptomRegistrationState> emit) async {
    final intensities = Map<String, int>.from(state.symptomIntensities);
    intensities[event.symptom] = event.intensity;
    
    emit(state.copyWith(
      symptomIntensities: intensities,
    ));
  }

  Future<void> _onUpdateDescription(UpdateDescription event, Emitter<SymptomRegistrationState> emit) async {
    emit(state.copyWith(
      description: event.description,
    ));
  }

  Future<void> _onSubmitSymptoms(SubmitSymptoms event, Emitter<SymptomRegistrationState> emit) async {
    emit(state.copyWith(status: SymptomRegistrationStatus.submitting));
    try {
      final entry = SymptomEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        symptoms: state.selectedSymptoms,
        symptomIntensities: state.symptomIntensities,
        description: state.description,
      );
      /*
      context.read<EntryBloc>().add(AddEntryEvent(entry));
      Navigator.pop(context);
       */

      await addEntry.call(entry);
      emit(state.copyWith(
          status: SymptomRegistrationStatus.submitted,
          entry: entry
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to save symptoms: $e'));
    }
  }
}

abstract class SymptomRegistrationEvent {}

class SelectSymptoms extends SymptomRegistrationEvent {
  final String symptom;

  SelectSymptoms(this.symptom);
}

class UpdateSymptomIntensity extends SymptomRegistrationEvent {
  final String symptom;
  final int intensity;

  UpdateSymptomIntensity(this.symptom, this.intensity);
}

class UpdateDescription extends SymptomRegistrationEvent {
  final String? description;

  UpdateDescription(this.description);
}

class SubmitSymptoms extends SymptomRegistrationEvent {}

@immutable
class SymptomRegistrationState {
  final List<String> selectedSymptoms;
  final Map<String, int> symptomIntensities;
  final SymptomEntry? entry;
  final String? description;
  final String? error;
  final SymptomRegistrationStatus status;

  const SymptomRegistrationState({
    this.selectedSymptoms = const [],
    this.symptomIntensities = const {},
    this.entry,
    this.description,
    this.error,
    this.status = SymptomRegistrationStatus.initial,
  });

  SymptomRegistrationState copyWith({
    List<String>? selectedSymptoms,
    Map<String, int>? symptomIntensities,
    SymptomEntry? entry,
    String? description,
    String? error,
    SymptomRegistrationStatus? status,
  }) {
    return SymptomRegistrationState(
      selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
      symptomIntensities: symptomIntensities ?? this.symptomIntensities,
      entry: entry ?? this.entry,
      description: description ?? this.description,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}

enum SymptomRegistrationStatus {
  initial,
  symptomsSelected,
  intensitySet,
  submitting,
  submitted,
  error,
}