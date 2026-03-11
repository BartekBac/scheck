import 'package:equatable/equatable.dart';
import 'package:scheck/core/enums/meal_type.dart';
import 'package:scheck/core/enums/mood.dart';

abstract class Entry extends Equatable {
  final String id;
  final String userId;
  final DateTime timestamp;
  final String? description;
  
  const Entry({
    required this.id,
    required this.userId,
    required this.timestamp,
    this.description,
  });

  @override
  List<Object?> get props => [id, userId, timestamp, description];
}

class MealEntry extends Entry {
  final String? localImageUrl;
  final String? remoteImageUrl;
  final MealType mealType;
  final List<String> ingredients;
  final Mood? moodBeforeMeal;

  const MealEntry({
    required super.id,
    required super.userId,
    required super.timestamp,
    this.localImageUrl,
    this.remoteImageUrl,
    required this.mealType,
    required this.ingredients,
    this.moodBeforeMeal,
    super.description,
  });

  @override
  List<Object?> get props => [id, userId, timestamp, description, localImageUrl, remoteImageUrl, mealType, ingredients, moodBeforeMeal];
}

class SymptomEntry extends Entry {
  final List<String> symptoms;
  final Map<String, int> symptomIntensities;

  const SymptomEntry({
    required super.id,
    required super.userId,
    required super.timestamp,
    required this.symptoms,
    required this.symptomIntensities,
    super.description,
  });

  @override
  List<Object?> get props => [id, userId, timestamp, description, symptoms, symptomIntensities];
}

