import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:scheck/core/models/meal_analyzer_response.dart';
import 'package:scheck/core/services/image_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as d;

@LazySingleton()
class MealAnalyzer {
  final SupabaseClient _supabase;
  final ImageService _imageService;

  MealAnalyzer(this._supabase, this._imageService);

  Future<MealAnalyzerResponse> analyzeMeal(File image) async {
    try {
      final base64Image = await _imageService.baseEncodeImage(image);

      final response = await _supabase.functions.invoke(

        'analyze-meal',
        body: {'imageBase64': base64Image},
      );

      if (response.status != 200) {
        d.log('Error calling analyze-meal supabase function, response status: ${response.status}, details: ${response.data.toString()}');
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

      return MealAnalyzerResponse.fromJson(jsonMap);
    } catch (e) {
      d.log('Unexpected error in MealAnalyzer, details: ${e.toString()}');
      rethrow;
    }
  }
}