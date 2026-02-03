import 'package:scheck/core/entities/entry.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel {
  final String id;
  final int timestamp;
  final String type;
  final String data;
  final String? description;

  EntryModel({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.data,
    this.description,
  });

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      id: map['id'] as String,
      timestamp: map['timestamp'] as int,
      type: map['type'] as String,
      data: map['data'] as String,
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'type': type,
      'data': data,
      'description': description,
    };
  }

  static EntryModel fromEntity(Entry entry) {
    String type;
    String data;
    
    if (entry is MealEntry) {
      type = 'meal';
      data = jsonEncode(MealData(
        imageUrl: entry.imageUrl,
        mealType: entry.mealType.name,
        ingredients: entry.ingredients,
        moodBeforeMeal: entry.moodBeforeMeal?.name,
      ).toJson());
    } else if (entry is SymptomEntry) {
      type = 'symptom';
      data = jsonEncode(SymptomData(
        symptoms: entry.symptoms,
        symptomIntensities: entry.symptomIntensities,
      ).toJson());
    } else {
      throw Exception('Unknown entry type');
    }
    
    return EntryModel(
      id: entry.id,
      timestamp: entry.timestamp.millisecondsSinceEpoch,
      type: type,
      data: data,
      description: entry.description,
    );
  }

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryModelToJson(this);
}

extension EntryModelExtension on EntryModel {
  Entry toEntity() {
    switch (type) {
      case 'meal':
        final mealData = MealData.fromJson(jsonDecode(data) as Map<String, dynamic>);
        return MealEntry(
          id: id,
          timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
          imageUrl: mealData.imageUrl,
          mealType: MealType.values.byName(mealData.mealType),
          ingredients: mealData.ingredients,
          moodBeforeMeal: mealData.moodBeforeMeal != null ? Mood.values.byName(mealData.moodBeforeMeal!) : null,
          description: description,
        );
      case 'symptom':
        final symptomData = SymptomData.fromJson(jsonDecode(data) as Map<String, dynamic>);
        return SymptomEntry(
          id: id,
          timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
          symptoms: symptomData.symptoms,
          symptomIntensities: symptomData.symptomIntensities,
          description: description,
        );
      default:
        throw Exception('Unknown entry type: $type');
    }
  }
}

@JsonSerializable()
class MealData {
  final String imageUrl;
  final String mealType;
  final List<String> ingredients;
  final String? moodBeforeMeal;

  MealData({
    required this.imageUrl,
    required this.mealType,
    required this.ingredients,
    this.moodBeforeMeal,
  });

  factory MealData.fromJson(Map<String, dynamic> json) =>
      _$MealDataFromJson(json);

  Map<String, dynamic> toJson() => _$MealDataToJson(this);
}

@JsonSerializable()
class SymptomData {
  final List<String> symptoms;
  final Map<String, int> symptomIntensities;

  SymptomData({
    required this.symptoms,
    required this.symptomIntensities,
  });

  factory SymptomData.fromJson(Map<String, dynamic> json) =>
      _$SymptomDataFromJson(json);

  Map<String, dynamic> toJson() => _$SymptomDataToJson(this);
}