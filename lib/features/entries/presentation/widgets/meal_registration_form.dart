import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart';
import 'package:scheck/features/navigation/presentation/bloc/navigation_bloc.dart';

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
              const _IngredientsSection(),
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
    final bloc = context.read<MealRegistrationBloc>();
    final state = bloc.state;
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
            showModalBottomSheet(
              context: context,
              builder: (bottomSheetContext) => SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final picker = ImagePicker();
                                final image = await picker.pickImage(source: ImageSource.camera);
                                if (image != null) {
                                  bloc.add(SelectImage(image.path));
                                  if (bottomSheetContext.mounted) {
                                    Navigator.pop(bottomSheetContext);
                                  }
                                }
                              } catch (e) {
                                log(e.toString(), error: e);
                                if (bottomSheetContext.mounted) {
                                  Navigator.pop(bottomSheetContext);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Camera not available. Use gallery instead.'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Camera'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final picker = ImagePicker();
                                final image = await picker.pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  bloc.add(SelectImage(image.path));
                                  if (bottomSheetContext.mounted) {
                                    Navigator.pop(bottomSheetContext);
                                  }
                                }
                              } catch (e) {
                                log(e.toString(), error: e);
                                if (bottomSheetContext.mounted) {
                                  Navigator.pop(bottomSheetContext);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Gallery not available.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Gallery'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(bottomSheetContext),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            );
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
                    child: Image.file(
                      File(state.imageUrl),
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
              label: Text(type.label),
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

/*  Widget _buildIngredientsSection(BuildContext context) {
    return BlocBuilder<MealRegistrationBloc, MealRegistrationState>(
      buildWhen: (previous, current) => previous.ingredients != current.ingredients,
      builder: (context, state) {
        return StatefulBuilder(
          builder: (context, setState) {
            final controller = TextEditingController(text: state.ingredientsText);
            //final ingredientsText = state.ingredients.join(', ');
            //controller.text = 'test';//ingredientsText;

            /*controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
*/
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter ingredients separated by commas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    final endsWithCommaAndWhitespace = RegExp(r',\s*$');
                    if(!endsWithCommaAndWhitespace.hasMatch(value,)) {
                      final ingredients = value
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList();
                      context.read<MealRegistrationBloc>().add(
                          UpdateIngredients(ingredients));
                    }
                  },
                ),
                if (state.ingredients.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: state.ingredients.map((ingredient) {
                        return Chip(
                          label: Text(ingredient),
                          backgroundColor: Colors.orange[100],
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            final updatedIngredients = List<String>.from(state.ingredients)..remove(ingredient);
                            context.read<MealRegistrationBloc>().add(UpdateIngredients(updatedIngredients));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
*/

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
                  mood.icon,
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
      onPressed: () {
        context.read<MealRegistrationBloc>().add(SubmitMeal());
        context.read<NavigationBloc>().add(NavigationEvent.pageChanged(0));
      },
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

}

class _IngredientsSection extends StatefulWidget {
  const _IngredientsSection();

  @override
  State<_IngredientsSection> createState() => _IngredientsSectionState();
}

class _IngredientsSectionState extends State<_IngredientsSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<MealRegistrationBloc>();
    _controller.text = bloc.state.ingredients.join(', ');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealRegistrationBloc, MealRegistrationState>(
      listenWhen: (previous, current) => previous.ingredients != current.ingredients,
      listener: (context, state) {
        final newText = state.ingredientsText;
        if (newText != _controller.text) {
          _controller.text = newText;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingredients',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter ingredients separated by commas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              final endsWithCommaAndWhitespace = RegExp(r',\s*$');
              final endsWithSpace = RegExp(r'\s$');
              if (!(endsWithCommaAndWhitespace.hasMatch(value) || endsWithSpace.hasMatch(value))) {
                final ingredients = value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
                context.read<MealRegistrationBloc>().add(UpdateIngredients(ingredients));
              }
            },
          ),
          BlocBuilder<MealRegistrationBloc, MealRegistrationState>(
            buildWhen: (p, c) => p.ingredients != c.ingredients,
            builder: (context, state) {
              if (state.ingredients.isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: state.ingredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient),
                      backgroundColor: Colors.orange[100],
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        final updatedIngredients = List<String>.from(state.ingredients)..remove(ingredient);
                        context.read<MealRegistrationBloc>().add(UpdateIngredients(updatedIngredients));
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}