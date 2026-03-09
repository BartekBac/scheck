// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_meal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyzeMealResponse _$AnalyzeMealResponseFromJson(Map<String, dynamic> json) =>
    AnalyzeMealResponse(
      mealType: $enumDecode(_$MealTypeEnumMap, json['mealType']),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$AnalyzeMealResponseToJson(
  AnalyzeMealResponse instance,
) => <String, dynamic>{
  'mealType': _$MealTypeEnumMap[instance.mealType]!,
  'ingredients': instance.ingredients,
  'description': instance.description,
};

const _$MealTypeEnumMap = {
  MealType.breakfast: 'breakfast',
  MealType.lunch: 'lunch',
  MealType.dinner: 'dinner',
  MealType.snack: 'snack',
  MealType.supper: 'supper',
  MealType.other: 'other',
};
