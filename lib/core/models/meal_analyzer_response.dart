import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../entities/entry.dart';

part 'meal_analyzer_response.g.dart';

@JsonSerializable()
class MealAnalyzerResponse extends Equatable {
  final MealType mealType;
  final List<String> ingredients;
  final String description;

  const MealAnalyzerResponse({
    required this.mealType,
    required this.ingredients,
    required this.description,
  });

  factory MealAnalyzerResponse.fromMap(Map<String, dynamic> map) {
    return MealAnalyzerResponse(
      mealType: MealType.values.firstWhere(
        (type) => type.name == map['meal_type'] as String,
        orElse: () => MealType.other,
      ),
      ingredients: List<String>.from(map['ingredients'] as List),
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meal_type': mealType.name,
      'ingredients': ingredients,
      'description': description,
    };
  }

  factory MealAnalyzerResponse.fromJson(Map<String, dynamic> json) =>
      _$MealAnalyzerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealAnalyzerResponseToJson(this);

  @override
  List<Object?> get props => [mealType, ingredients, description];
}