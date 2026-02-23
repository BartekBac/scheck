import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/core/utils/message_facade.dart';
import 'package:scheck/features/entries/domain/usecases/add_entry.dart';
import 'package:scheck/features/entries/presentation/widgets/meal_registration_form.dart';
import 'package:scheck/injection.dart';
import 'dart:developer' as developer;
import 'package:supabase_flutter/supabase_flutter.dart';

class MealRegistrationPage extends StatelessWidget {
  const MealRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MealRegistrationBloc>(),
      child: const MealRegistrationForm(),
    );
  }
}

@injectable
class MealRegistrationBloc extends Bloc<MealRegistrationEvent, MealRegistrationState> {
  final AddEntry addEntry;
  final SupabaseClient supabaseClient;

  MealRegistrationBloc({required this.addEntry, required this.supabaseClient})
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
      status: MealRegistrationStatus.editing,
    ));
  }

  Future<void> _onUpdateMealType(UpdateMealType event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      mealType: event.mealType,
      status: MealRegistrationStatus.editing,
    ));
  }

  Future<void> _onUpdateIngredients(UpdateIngredients event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      ingredients: event.ingredients,
      status: MealRegistrationStatus.editing,
    ));
  }

  Future<void> _onUpdateMood(UpdateMood event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      moodBeforeMeal: event.mood,
      status: MealRegistrationStatus.editing,
    ));
  }

  Future<void> _onUpdateDescription(UpdateDescription event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(
      description: event.description,
      status: MealRegistrationStatus.editing,
    ));
  }

  Future<void> _onSubmitMeal(SubmitMeal event, Emitter<MealRegistrationState> emit) async {
    emit(state.copyWith(status: MealRegistrationStatus.submitting));
    try {
      final entry = MealEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: supabaseClient.auth.currentUser?.id ?? '',
        timestamp: DateTime.now(),
        imageUrl: state.imageUrl,
        mealType: state.mealType,
        ingredients: state.ingredients,
        moodBeforeMeal: state.moodBeforeMeal,
        description: state.description,
      );

      await addEntry.call(entry);
      // reset state
      emit(const MealRegistrationState());
    } catch (e) {
      developer.log(e.toString());
      emit(state.copyWith(status: MealRegistrationStatus.error, error: MessageFacade.mealSaveError));
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
  final String? description;
  final MessageFacade? error;
  final MealRegistrationStatus status;

  bool get readyToSave => imageUrl.isNotEmpty;
  String get ingredientsText => ingredients.join(', ');

  const MealRegistrationState({
    this.imageUrl = '',
    this.mealType = MealType.other,
    this.ingredients = const [],
    this.moodBeforeMeal,
    this.description,
    this.error,
    this.status = MealRegistrationStatus.initial,
  });

  MealRegistrationState copyWith({
    String? imageUrl,
    MealType? mealType,
    List<String>? ingredients,
    Mood? moodBeforeMeal,
    String? description,
    MessageFacade? error,
    MealRegistrationStatus? status,
  }) {
    return MealRegistrationState(
      imageUrl: imageUrl ?? this.imageUrl,
      mealType: mealType ?? this.mealType,
      ingredients: ingredients ?? this.ingredients,
      moodBeforeMeal: moodBeforeMeal ?? this.moodBeforeMeal,
      description: description ?? this.description,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}

enum MealRegistrationStatus {
  initial,
  editing,
  submitting,
  error,
}