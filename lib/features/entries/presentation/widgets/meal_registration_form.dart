import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart';

class MealRegistrationForm extends StatelessWidget {
  const MealRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealRegistrationBloc, MealRegistrationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImageSection(context),
              const SizedBox(height: 24),
              _buildMealTypeSelector(context),
              const SizedBox(height: 24),
              _buildIngredientsSection(context),
              const SizedBox(height: 24),
              _buildMoodSection(context),
              const SizedBox(height: 24),
              _buildDescriptionSection(context),
              const SizedBox(height: 32),
              _buildSubmitButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final state = context.read<MealRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meal Photo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // TODO: Open camera
            context.read<MealRegistrationBloc>().add(SelectImage('placeholder_url'));
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child: state.imageUrl.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Tap to take photo', style: TextStyle(color: Colors.grey)),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      state.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealTypeSelector(BuildContext context) {
    final state = context.read<MealRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meal Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MealType.values.map((type) {
            return ChoiceChip(
              label: Text(_getMealTypeLabel(type)),
              selected: state.mealType == type,
              onSelected: (selected) {
                if (selected) {
                  context.read<MealRegistrationBloc>().add(UpdateMealType(type));
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.orange,
              labelStyle: TextStyle(
                color: state.mealType == type ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIngredientsSection(BuildContext context) {
    final state = context.read<MealRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter ingredients separated by commas',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Add ingredients
              },
            ),
          ),
          onChanged: (value) {
            final ingredients = value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
            context.read<MealRegistrationBloc>().add(UpdateIngredients(ingredients));
          },
        ),
        if (state.ingredients.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: state.ingredients.map((ingredient) => Chip(
              label: Text(ingredient),
              backgroundColor: Colors.orange[100],
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {
                final updated = List<String>.from(state.ingredients)..remove(ingredient);
                context.read<MealRegistrationBloc>().add(UpdateIngredients(updated));
              },
            )).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildMoodSection(BuildContext context) {
    final state = context.read<MealRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mood Before Meal',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: Mood.values.map((mood) {
            return GestureDetector(
              onTap: () {
                context.read<MealRegistrationBloc>().add(UpdateMood(mood));
              },
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: state.moodBeforeMeal == mood ? Colors.orange : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: state.moodBeforeMeal == mood ? Colors.orange : Colors.grey[100],
                ),
                child: Icon(
                  _getMoodIcon(mood),
                  color: state.moodBeforeMeal == mood ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any additional notes...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            context.read<MealRegistrationBloc>().add(UpdateDescription(value.isEmpty ? null : value));
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, MealRegistrationState state) {
    return ElevatedButton(
      onPressed: state.status == MealRegistrationStatus.imageSelected
          ? () {
              context.read<MealRegistrationBloc>().add(SubmitMeal());
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Save Meal Entry',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
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
}