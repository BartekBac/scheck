import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/usecases/add_entry.dart';
import 'package:scheck/features/entries/presentation/widgets/symptom_registration_form.dart';
import 'package:scheck/injection.dart';
import 'package:scheck/l10n/l10n.dart';
import 'dart:developer' as developer;

class SymptomRegistrationPage extends StatelessWidget {
  const SymptomRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SymptomRegistrationBloc>(),
      child: const SymptomRegistrationForm(),
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
    final symptomIntensities = Map<String, int>.from(state.symptomIntensities);
    if (selectedSymptoms.contains(event.symptom)) {
      selectedSymptoms.remove(event.symptom);
      symptomIntensities.remove(event.symptom);
    } else {
      selectedSymptoms.add(event.symptom);
      symptomIntensities.putIfAbsent(event.symptom, () => 1);
    }

    emit(state.copyWith(
      selectedSymptoms: selectedSymptoms,
      symptomIntensities: symptomIntensities,
      status: selectedSymptoms.isEmpty
          ? SymptomRegistrationStatus.initial
          : SymptomRegistrationStatus.editing,
    ));
  }

  Future<void> _onUpdateSymptomIntensity(UpdateSymptomIntensity event, Emitter<SymptomRegistrationState> emit) async {
    final intensities = Map<String, int>.from(state.symptomIntensities);
    intensities[event.symptom] = event.intensity;

    emit(state.copyWith(
      symptomIntensities: intensities,
      status: SymptomRegistrationStatus.editing
    ));
  }

  Future<void> _onUpdateDescription(UpdateDescription event, Emitter<SymptomRegistrationState> emit) async {
    emit(state.copyWith(
      description: event.description,
      status: SymptomRegistrationStatus.editing
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

      await addEntry.call(entry);
      // reset state
      emit(const SymptomRegistrationState());
    } catch (e) {
      developer.log(e.toString());
      emit(state.copyWith(status: SymptomRegistrationStatus.error, error: SymptomRegistrationError.saveError));
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

enum SymptomRegistrationError {
  saveError
}

extension SymptomRegistrationErrorExtension on SymptomRegistrationError {
  String getMessage(AppLocalizations l10n) => switch(this) {
    SymptomRegistrationError.saveError => l10n.errorFailedToSaveSymptoms
  };
}

@immutable
class SymptomRegistrationState {
  final List<String> selectedSymptoms;
  final Map<String, int> symptomIntensities;
  final String? description;
  final SymptomRegistrationError? error;
  final SymptomRegistrationStatus status;

  bool get readyToSave => selectedSymptoms.isNotEmpty;

  const SymptomRegistrationState({
    this.selectedSymptoms = const [],
    this.symptomIntensities = const {},
    this.description,
    this.error,
    this.status = SymptomRegistrationStatus.initial,
  });

  SymptomRegistrationState copyWith({
    List<String>? selectedSymptoms,
    Map<String, int>? symptomIntensities,
    String? description,
    SymptomRegistrationError? error,
    SymptomRegistrationStatus? status,
  }) {
    return SymptomRegistrationState(
      selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
      symptomIntensities: symptomIntensities ?? this.symptomIntensities,
      description: description ?? this.description,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}

enum SymptomRegistrationStatus {
  initial,
  editing,
  submitting,
  error,
}
