import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

extension MealTypeExtension on MealType {
  String get label => switch(this) {
    MealType.breakfast => 'Breakfast',
    MealType.lunch => 'Lunch',
    MealType.dinner => 'Dinner',
    MealType.snack => 'Snack',
    MealType.other => 'Other',
  };
}

extension MoodExtension on Mood {
  IconData get icon => switch(this) {
    Mood.great => Icons.sentiment_very_satisfied,
    Mood.good => Icons.sentiment_satisfied,
    Mood.neutral => Icons.sentiment_neutral,
    Mood.bad => Icons.sentiment_dissatisfied,
    Mood.terrible => Icons.sentiment_very_dissatisfied
  };
}