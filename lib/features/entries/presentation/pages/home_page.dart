import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        if (state is EntryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is EntryError) {
          return Center(child: Text(state.message));
        }
        if (state is EntryLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.entries.length,
            itemBuilder: (context, index) {
              final entry = state.entries[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(entry.timestamp.toString().substring(0, 16)),
                  subtitle: Text(
                    switch (entry) {
                      MealEntry _ => 'Meal: ${entry.mealType.name}',
                      SymptomEntry _ =>
                        'Symptoms: ${entry.symptoms.join(", ")}',
                      Entry _ => throw UnimplementedError(),
                    },
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showEntryDetailsDialog(context, entry);
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
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
}
