import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

/*
@LazySingleton()
class EntryRepositoryMock implements EntryRepository {
  final List<Entry> _entries = [
    MealEntry(
      id: '1',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      imageUrl: 'https://via.placeholder.com/200',
      mealType: MealType.lunch,
      ingredients: ['Chicken', 'Rice', 'Vegetables'],
      moodBeforeMeal: Mood.good,
      description: 'Lunch at home',
    ),
    SymptomEntry(
      id: '2',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      symptoms: ['Bloating', 'Fatigue'],
      symptomIntensities: {'Bloating': 3, 'Fatigue': 5},
      description: 'Felt bloated after lunch',
    ),
  ];

  @override
  Future<List<Entry>> getEntries() async {
    // Return mock data for testing
    return _entries;
  }

  @override
  Future<void> addEntry(Entry entry) async {
    // Mock implementation - just return successfully
    _entries.add(entry);
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> deleteEntry(String id) async {
    _entries.removeWhere((e) => e.id == id);
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

 */