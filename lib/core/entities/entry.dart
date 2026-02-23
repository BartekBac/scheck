import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/utils/icon_facade.dart';

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
  final String imageUrl; //TODO: move image save on remote database
  final MealType mealType;
  final List<String> ingredients;
  final Mood? moodBeforeMeal;

  const MealEntry({
    required super.id,
    required super.userId,
    required super.timestamp,
    required this.imageUrl,
    required this.mealType,
    required this.ingredients,
    this.moodBeforeMeal,
    super.description,
  });

  @override
  List<Object?> get props => [id, userId, timestamp, description, imageUrl, mealType, ingredients, moodBeforeMeal];
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
    Mood.great => IconFacade.great,
    Mood.good => IconFacade.good,
    Mood.neutral => IconFacade.neutral,
    Mood.bad => IconFacade.bad,
    Mood.terrible => IconFacade.terrible
  };

  String get label => switch(this) {
    Mood.great => 'Great',
    Mood.good => 'Good',
    Mood.neutral => 'Neutral',
    Mood.bad => 'Bad',
    Mood.terrible => 'Terrible'
  };

  Color getColor(BuildContext context) => switch(this) {
    Mood.great => ColorStyler.Positive.color(context),
    Mood.good => ColorStyler.Positive.scaledColor(context, ratio: 0.8),
    Mood.neutral => ColorStyler.Surface.scaledOnColor(context, ratio: 0.6),
    Mood.bad => ColorStyler.Negative.scaledColor(context, ratio: 0.8),
    Mood.terrible => ColorStyler.Negative.color(context),
  };
}
