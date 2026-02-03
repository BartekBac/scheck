import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheck/core/entities/entry.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;

  const EntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            if (entry is MealEntry) _buildMealDetails(entry as MealEntry),
            if (entry is SymptomEntry) _buildSymptomDetails(entry as SymptomEntry),
            if (entry.description != null) ...[
              const SizedBox(height: 12),
              _buildDescription(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('yyyy-MM-dd');
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeFormat.format(entry.timestamp),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateFormat.format(entry.timestamp),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        _buildEntryTypeIcon(),
      ],
    );
  }

  Widget _buildEntryTypeIcon() {
    if (entry is MealEntry) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.restaurant,
          color: Colors.orange,
          size: 24,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.sick,
          color: Colors.red,
          size: 24,
        ),
      );
    }
  }

  Widget _buildMealDetails(MealEntry mealEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Meal Type', _getMealTypeLabel(mealEntry.mealType)),
        if (mealEntry.ingredients.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildInfoRow('Ingredients', mealEntry.ingredients.join(', ')),
        ],
        if (mealEntry.moodBeforeMeal != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Mood: '),
              const SizedBox(width: 4),
              Icon(
                _getMoodIcon(mealEntry.moodBeforeMeal!),
                color: _getMoodColor(mealEntry.moodBeforeMeal!),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                _getMoodLabel(mealEntry.moodBeforeMeal!),
                style: TextStyle(
                  color: _getMoodColor(mealEntry.moodBeforeMeal!),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSymptomDetails(SymptomEntry symptomEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ...symptomEntry.symptoms.map((symptom) {
          final intensity = symptomEntry.symptomIntensities[symptom] ?? 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      symptom,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '$intensity/10',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: intensity / 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(entry.description!),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  String _getMealTypeLabel(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
      case MealType.other:
        return 'Other';
    }
  }

  String _getMoodLabel(Mood mood) {
    switch (mood) {
      case Mood.great:
        return 'Great';
      case Mood.good:
        return 'Good';
      case Mood.neutral:
        return 'Neutral';
      case Mood.bad:
        return 'Bad';
      case Mood.terrible:
        return 'Terrible';
    }
  }

  IconData _getMoodIcon(Mood mood) {
    switch (mood) {
      case Mood.great:
        return Icons.sentiment_very_satisfied;
      case Mood.good:
        return Icons.sentiment_satisfied;
      case Mood.neutral:
        return Icons.sentiment_neutral;
      case Mood.bad:
        return Icons.sentiment_dissatisfied;
      case Mood.terrible:
        return Icons.sentiment_very_dissatisfied;
    }
  }

  Color _getMoodColor(Mood mood) {
    switch (mood) {
      case Mood.great:
        return Colors.green;
      case Mood.good:
        return Colors.lightGreen;
      case Mood.neutral:
        return Colors.orange;
      case Mood.bad:
        return Colors.orange[700]!;
      case Mood.terrible:
        return Colors.red;
    }
  }
}