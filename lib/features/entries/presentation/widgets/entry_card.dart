import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';

class EntryCard extends StatefulWidget {
  final Entry entry;

  EntryCard({super.key, required this.entry});

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  bool _showBottomMenu = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                _showBottomMenu = !_showBottomMenu;
              }),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 12),
                    if (widget.entry is MealEntry) _buildMealDetails(widget.entry as MealEntry),
                    if (widget.entry is SymptomEntry) _buildSymptomDetails(widget.entry as SymptomEntry),
                    if (widget.entry.description != null) ...[
                      const SizedBox(height: 12),
                      _buildDescription(),
                    ],

                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Visibility(
                visible: _showBottomMenu,
                child: _buildBottomMenu(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomMenu(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)), color: Colors.amber),
            child: Row(children: [
              Expanded(child: InkWell(
                onTap: () => _showEntryDetailsDialog(context, widget.entry),
                child: ColoredBox(color: Colors.grey,  child: Center(child: Text('Info')))
              )),
              Expanded(child: InkWell(
                onTap: () => DialogHandler.showConfirmDialog(context, 'Are you sure you want to delete this entry?')
                    .then((confirmed) => confirmed ? context.read<EntryBloc>().add(DeleteEntryEvent(widget.entry)) : null),
                child: ColoredBox(color:Colors.red, child: Center(child: Text('Delete')))
              )) //TODO start using ColorStyler and IconStyler
            ],
            ),
          ),
        ),
      ],
    );
  }


  void _showEntryDetailsDialog(BuildContext context, Entry entry) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(entry.timestamp.toString().substring(0, 16)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [Text('Id: ${entry.id}')]),
            if (entry is SymptomEntry)...[
              Row(
                children: [
                  Text(
                    'Symptoms: ${entry.symptoms.join(", ")}',
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Intensities: ${entry.symptomIntensities.toString()}')
                ],
              )
            ],
            if (entry is MealEntry)
              ...[
                Row(children: [
                  Text('Meal: ${entry.mealType.name}'),
                ]),
                Row(children: [
                  Flexible(
                    child: Text('Image: ${entry.imageUrl}'),
                  ),
                ]),
                Row(children: [
                  Text('Mood: '),
                  Icon(
                    entry.moodBeforeMeal?.icon ?? Icons.do_not_disturb_sharp,
                    size: 20,
                  ),
                  Text(
                      entry.moodBeforeMeal?.name ?? 'N/A'
                  ),
                ],),
                Row(children: [
                  Text('Ingredients: ${entry.ingredients.join(", ")}'),
                ],),
              ],
            if (entry.description != null)
              Text('Description: ${entry.description}'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () async {
              context.read<EntryBloc>().add(DeleteEntryEvent(entry));
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
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
              timeFormat.format(widget.entry.timestamp),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateFormat.format(widget.entry.timestamp),
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
    if (widget.entry is MealEntry) {
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

  Widget _buildMealImage(MealEntry mealEntry) {
    if (widget.entry is MealEntry) {
      final imageUrl = Uri.parse(mealEntry.imageUrl);
      if (imageUrl.isScheme('http') || imageUrl.isScheme('https')) {
        return Image.network(
          mealEntry.imageUrl,
          width: double.infinity,
          height: 100,
          fit: BoxFit.cover,
        );
      } else {
        return Image.file(
          File(mealEntry.imageUrl),
          width: double.infinity,
          height: 100,
          fit: BoxFit.cover,
        );
      }
    } else {
      return const SizedBox();
    }
  }

  Widget _buildMealDetails(MealEntry mealEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Meal Type', _getMealTypeLabel(mealEntry.mealType)),
        _buildMealImage(mealEntry),
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
          Text(widget.entry.description!),
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