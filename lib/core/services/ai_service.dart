import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/models/analyze_meal_response.dart';
import 'package:scheck/core/services/image_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as d;

@LazySingleton()
class AIService {
  final SupabaseClient _supabase;
  final ImageService _imageService;

  AIService(this._supabase, this._imageService);

  Future<T> _process<T>({
    required T Function(Map<String, dynamic>) fromJson,
    String? systemPrompt,
    String? userPrompt,
    String? imageBase64,
    bool? returnAsJson
  }) async {
    try {
      final response = await _supabase.functions.invoke(
        'ai-processor',
        body: {
          if (systemPrompt != null) 'system_prompt': systemPrompt,
          if (userPrompt != null) 'user_prompt': userPrompt,
          if (imageBase64 != null) 'image_base_64': imageBase64,
          if (returnAsJson != null) 'return_as_json': returnAsJson,
        },
      );

      if (response.status != 200) {
        d.log('Error calling ai-processor supabase function, response status: ${response.status}, details: ${response.data.toString()}');
        throw Exception(response.data.toString());
      }

      // Safely parse the response data
      Map<String, dynamic> jsonMap;
      if (response.data is Map) {
        jsonMap = Map<String, dynamic>.from(response.data as Map<String, dynamic>);
      } else if (response.data is String) {
        // If the function returned a raw string, decode it manually
        jsonMap = jsonDecode(response.data as String) as Map<String, dynamic>;
      } else {
        throw Exception('Unexpected response format: ${response.data.runtimeType}');
      }

      return fromJson(jsonMap);
    } catch (e) {
      d.log('Unexpected error in MealAnalyzer, details: ${e.toString()}');
      rethrow;
    }
  }

  Future<AnalyzeMealResponse> analyzeMeal(File image) async {
    final systemPrompt = "You are a food recognition assistant."
        " Return ONLY raw JSON in this format: ${AnalyzeMealResponse.jsonFormat}"
        " No markdown. No explanation. ";
    final encodedImage = await _imageService.baseEncodeImage(image);
    return _process<AnalyzeMealResponse>(
      fromJson: AnalyzeMealResponse.fromJson,
      systemPrompt: systemPrompt,
      imageBase64: encodedImage,
      returnAsJson: true
    );
  }
}