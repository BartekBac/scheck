import 'dart:async';
import 'dart:convert';

import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/data/datasources/entry_remote_data_source.dart';
import 'package:scheck/features/entries/data/datasources/supabase/entry_change.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

class EntryRemoteDataSourceMock implements EntryRemoteDataSource {
  final List<EntryModel> _mockEntries = [
    EntryModel(
      id: '1',
      userId: '1',
      timestamp: DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch,
      type: 'meal',
      data: jsonEncode(MealData(
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
        mealType: MealType.lunch.name,
        ingredients: ['Salad', 'Chicken', 'Tomato', 'Avocado'],
        moodBeforeMeal: Mood.good.name,
      ).toJson()),
      description: 'A very tasty and healthy salad for lunch.',
    ),
    EntryModel(
      id: '2',
      userId: '1',
      timestamp: DateTime.now().subtract(const Duration(hours: 18)).millisecondsSinceEpoch,
      type: 'symptom',
      data: jsonEncode(SymptomData(
        symptoms: ['Headache', 'Fatigue'],
        symptomIntensities: {'Headache': 3, 'Fatigue': 5},
      ).toJson()),
      description: 'Feeling tired all day with a nagging headache.',
    ),
    EntryModel(
      id: '3',
      userId: '1',
      timestamp: DateTime.now().subtract(const Duration(hours: 10)).millisecondsSinceEpoch,
      type: 'meal',
      data: jsonEncode(MealData(
        imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
        mealType: MealType.dinner.name,
        ingredients: ['Steak', 'Potatoes', 'Asparagus'],
        moodBeforeMeal: Mood.neutral.name,
      ).toJson()),
      description: 'Dinner with friends.',
    ),
    EntryModel(
      id: '4',
      userId: '1',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)).millisecondsSinceEpoch,
      type: 'symptom',
      data: jsonEncode(SymptomData(
        symptoms: ['Bloating'],
        symptomIntensities: {'Bloating': 7},
      ).toJson()),
      description: 'Feeling bloated after the dinner.',
    ),
  ];

  final StreamController<EntryChange> _controller = StreamController<EntryChange>.broadcast();

  @override
  Future<List<EntryModel>> fetchAll() async {
    // Return mock data for testing
    await Future.delayed(const Duration(milliseconds: 1000));
    return _mockEntries;
  }

  @override
  Future<void> insert(EntryModel entry) async {
    // Mock implementation - just return successfully
    _mockEntries.add(entry);
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.add(EntryInserted(entry: entry));
  }

  @override
  Future<void> delete(String id) async {
    _mockEntries.removeWhere((e) => e.id == id);
    await Future.delayed(const Duration(milliseconds: 1500));
    _controller.add(EntryDeleted(id: id));
  }

  @override
  Stream<EntryChange> watchRealtime() {
    return _controller.stream;
  }
}