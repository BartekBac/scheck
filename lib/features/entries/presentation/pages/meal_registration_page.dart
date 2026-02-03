import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/usecases/add_entry.dart';
import 'package:scheck/features/entries/presentation/widgets/meal_registration_form.dart';
import 'package:scheck/injection.dart';

class MealRegistrationPage extends StatelessWidget {
  const MealRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Meal'),
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => getIt<MealRegistrationBloc>(),
        /*create: (context) => MealRegistrationBloc(
          addEntry: AddEntry(EntryRepositoryMock())
        ),*/
        child: const MealRegistrationForm(),
      ),
    );
  }
}

@injectable
class MealRegistrationBloc extends Bloc<MealRegistrationEvent, MealRegistrationState> {
  final AddEntry addEntry;

  MealRegistrationBloc({required this.addEntry})
      : super(const MealRegistrationState()) {
    on<SelectImage>(_onSelectImage);
    on<UpdateMealType>(_onUpdateMealType);
    on<UpdateIngredients>(_onUpdateIngredients);
    on<UpdateMood>(_onUpdateMood);
    on<UpdateDescription>(_onUpdateDescription);
    on<SubmitMeal>(_onSubmitMeal);
  }

  Future<void> _onSelectImage(SelectImage event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      imageUrl: event.imageUrl,
      status: MealRegistrationStatus.imageSelected,
    ));
  }

  Future<void> _onUpdateMealType(UpdateMealType event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      mealType: event.mealType,
      status: MealRegistrationStatus.mealTypeSelected,
    ));
  }

  Future<void> _onUpdateIngredients(UpdateIngredients event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      ingredients: event.ingredients,
      status: MealRegistrationStatus.ingredientsAdded,
    ));
  }

  Future<void> _onUpdateMood(UpdateMood event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      moodBeforeMeal: event.mood,
      status: MealRegistrationStatus.moodSelected,
    ));
  }

  Future<void> _onUpdateDescription(UpdateDescription event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      description: event.description,
    ));
  }
  //TODO: here AddEntry usecase should be used and EntryBloc should listen to repo streams of saving data via FormBlocs
  Future<void> _onSubmitMeal(SubmitMeal event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(status: MealRegistrationStatus.submitting));
    try {
      final entry = MealEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        imageUrl: state.imageUrl,
        mealType: state.mealType,
        ingredients: state.ingredients,
        moodBeforeMeal: state.moodBeforeMeal,
        description: state.description,
      );

      await addEntry.call(entry);

      emit(state.copyWith(
        status: MealRegistrationStatus.submitted,
        entry: entry,
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to submit meal: $e'));
    }
  }
}

abstract class MealRegistrationEvent {}

class SelectImage extends MealRegistrationEvent {
  final String imageUrl;

  SelectImage(this.imageUrl);
}

class UpdateMealType extends MealRegistrationEvent {
  final MealType mealType;

  UpdateMealType(this.mealType);
}

class UpdateIngredients extends MealRegistrationEvent {
  final List<String> ingredients;

  UpdateIngredients(this.ingredients);
}

class UpdateMood extends MealRegistrationEvent {
  final Mood? mood;

  UpdateMood(this.mood);
}

class UpdateDescription extends MealRegistrationEvent {
  final String? description;

  UpdateDescription(this.description);
}

class SubmitMeal extends MealRegistrationEvent {}


@immutable
class MealRegistrationState {
  final String imageUrl;
  final MealType mealType;
  final List<String> ingredients;
  final Mood? moodBeforeMeal;
  final MealEntry? entry;
  final String? description;
  final String? error;
  final MealRegistrationStatus status;

  const MealRegistrationState({
    this.imageUrl = '',
    this.mealType = MealType.other,
    this.ingredients = const [],
    this.moodBeforeMeal,
    this.entry,
    this.description,
    this.error,
    this.status = MealRegistrationStatus.initial,
  });

  MealRegistrationState copyWith({
    String? imageUrl,
    MealType? mealType,
    List<String>? ingredients,
    Mood? moodBeforeMeal,
    MealEntry? entry,
    String? description,
    String? error,
    MealRegistrationStatus? status,
  }) {
    return MealRegistrationState(
      imageUrl: imageUrl ?? this.imageUrl,
      mealType: mealType ?? this.mealType,
      ingredients: ingredients ?? this.ingredients,
      moodBeforeMeal: moodBeforeMeal ?? this.moodBeforeMeal,
      entry: entry ?? this.entry,
      description: description ?? this.description,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}

enum MealRegistrationStatus {
  initial,
  imageSelected,
  mealTypeSelected,
  ingredientsAdded,
  moodSelected,
  submitting,
  submitted,
  error,
}