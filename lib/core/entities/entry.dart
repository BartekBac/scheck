import 'package:equatable/equatable.dart';

abstract class Entry extends Equatable {
  final String id;
  final DateTime timestamp;
  final String? description;
  
  const Entry({
    required this.id,
    required this.timestamp,
    this.description,
  });

  @override
  List<Object?> get props => [id, timestamp, description];
}

class MealEntry extends Entry {
  final String imageUrl;
  final MealType mealType;
  final List<String> ingredients;
  final Mood? moodBeforeMeal;

  const MealEntry({
    required super.id,
    required super.timestamp,
    required this.imageUrl,
    required this.mealType,
    required this.ingredients,
    this.moodBeforeMeal,
    super.description,
  });

  @override
  List<Object?> get props => [id, timestamp, description, imageUrl, mealType, ingredients, moodBeforeMeal];
}

class SymptomEntry extends Entry {
  final List<String> symptoms;
  final Map<String, int> symptomIntensities;

  const SymptomEntry({
    required super.id,
    required super.timestamp,
    required this.symptoms,
    required this.symptomIntensities,
    super.description,
  });

  @override
  List<Object?> get props => [id, timestamp, description, symptoms, symptomIntensities];
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  other,
}

enum Mood {
  great,
  good,
  neutral,
  bad,
  terrible,
}