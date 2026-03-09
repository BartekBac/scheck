import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enums/meal_type.dart';

part 'analyze_meal_response.g.dart';

@JsonSerializable()
class AnalyzeMealResponse extends Equatable {
  final MealType mealType;
  final List<String> ingredients;
  final String description;

  const AnalyzeMealResponse({
    required this.mealType,
    required this.ingredients,
    required this.description,
  });

  factory AnalyzeMealResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyzeMealResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyzeMealResponseToJson(this);

  @override
  List<Object?> get props => [mealType, ingredients, description];

  /// ```json
  /// {
  ///   "mealType": "breakfast | lunch | dinner | snack | supper",
  ///   "ingredients": string[],
  ///   "description": string
  /// }
  /// ```
  static String get jsonFormat => "{ \"mealType\": \"breakfast | lunch | dinner | snack | supper\", \"ingredients\": string[], \"description\": string}";
}