// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) => EntryModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  type: json['type'] as String,
  data: json['data'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'data': instance.data,
      'description': instance.description,
    };

MealData _$MealDataFromJson(Map<String, dynamic> json) => MealData(
  imageUrl: json['imageUrl'] as String,
  mealType: json['mealType'] as String,
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  moodBeforeMeal: json['moodBeforeMeal'] as String?,
);

Map<String, dynamic> _$MealDataToJson(MealData instance) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
  'mealType': instance.mealType,
  'ingredients': instance.ingredients,
  'moodBeforeMeal': instance.moodBeforeMeal,
};

SymptomData _$SymptomDataFromJson(Map<String, dynamic> json) => SymptomData(
  symptoms: (json['symptoms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  symptomIntensities: Map<String, int>.from(json['symptomIntensities'] as Map),
);

Map<String, dynamic> _$SymptomDataToJson(SymptomData instance) =>
    <String, dynamic>{
      'symptoms': instance.symptoms,
      'symptomIntensities': instance.symptomIntensities,
    };
