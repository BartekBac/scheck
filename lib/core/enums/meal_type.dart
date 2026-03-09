import 'package:flutter/material.dart';
import 'package:scheck/l10n/l10n.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  supper,
  other,
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
