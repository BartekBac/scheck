import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/l10n/l10n.dart';

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

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  supper,
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
  String getLabel(BuildContext context) => switch(this) {
    MealType.breakfast => context.l10n.mealTypeBreakfast,
    MealType.lunch => context.l10n.mealTypeLunch,
    MealType.dinner => context.l10n.mealTypeDinner,
    MealType.snack => context.l10n.mealTypeSnack,
    MealType.supper => context.l10n.mealTypeSupper,
    MealType.other => context.l10n.mealTypeOther,
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

  String getLabel(BuildContext context) => switch(this) {
    Mood.great => context.l10n.moodGreat,
    Mood.good => context.l10n.moodGood,
    Mood.neutral => context.l10n.moodNeutral,
    Mood.bad => context.l10n.moodBad,
    Mood.terrible => context.l10n.moodTerrible
  };

  Color getColor(BuildContext context) => switch(this) {
    Mood.great => ColorStyler.Positive.color(context),
    Mood.good => ColorStyler.Positive.scaledColor(context, ratio: 0.8),
    Mood.neutral => ColorStyler.Surface.scaledOnColor(context, ratio: 0.6),
    Mood.bad => ColorStyler.Negative.scaledColor(context, ratio: 0.8),
    Mood.terrible => ColorStyler.Negative.color(context),
  };
}
