// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_analyzer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealAnalyzerResponse _$MealAnalyzerResponseFromJson(
  Map<String, dynamic> json,
) => MealAnalyzerResponse(
  mealType: $enumDecode(_$MealTypeEnumMap, json['mealType']),
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  description: json['description'] as String,
);

Map<String, dynamic> _$MealAnalyzerResponseToJson(
  MealAnalyzerResponse instance,
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
