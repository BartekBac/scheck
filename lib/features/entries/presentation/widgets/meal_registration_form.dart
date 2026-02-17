import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/stylers/text_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/core/utils/error_handler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/core/widgets/section_title.dart';
import 'package:scheck/core/widgets/submit_button.dart';
import 'package:scheck/features/entries/presentation/pages/meal_registration_page.dart';
import 'package:scheck/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class MealRegistrationForm extends StatelessWidget {
  const MealRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealRegistrationBloc, MealRegistrationState>(
      builder: (context, state) {
        return BlocListener<MealRegistrationBloc, MealRegistrationState>(
          listenWhen: (prev, curr) => curr.status == MealRegistrationStatus.error,
          listener: (context, state) {
            if(state.error != null) {
              ErrorHandler.showAtSnackBar(
                  context, state.error!.getMessage(context.l10n));
            }
          },
          child: SingleChildScrollView(
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
                const _DescriptionSection(),
                const SizedBox(height: 32),
                _buildSubmitButton(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImage(MealRegistrationBloc bloc, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      bloc.add(SelectImage(image.path));
    }
  }

  Widget _buildImageSection(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<MealRegistrationBloc>();
    final state = bloc.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitle(l10n.titleMealPhoto),
            IconButton(
              icon: Icon(IconFacade.gallery),
              color: ColorStyler.Primary.color(context),
              onPressed: () async {
                try {
                  _pickImage(bloc, ImageSource.gallery);
                } catch (e) {
                  log(e.toString(), error: e);
                  DialogHandler.showSnackBar(context, message: l10n.errorGalleryNotAvailable);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            try {
              _pickImage(bloc, ImageSource.camera);
            } catch (e) {
              log(e.toString(), error: e);
              DialogHandler.showSnackBar(context, message: l10n.errorCameraNotAvailable);
            }
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: ColorStyler.Surface.ultraLightOnColor(context)),
              borderRadius: ShapeStyler.InnerFieldShape.borderRadius,
              color: ColorStyler.SurfaceContainerLow.color(context),
            ),
            child: state.imageUrl.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(IconFacade.take_photo, size: 48, color: ColorStyler.Surface.ultraLightOnColor(context)),
                      const SizedBox(height: 8),
                      Text(l10n.hintTapToTakePhoto,
                          style: TextStyler.Title.small(context).copyWith(color: ColorStyler.Surface.ultraLightOnColor(context)))
                    ],
                  )
                : ClipRRect(
                    borderRadius: ShapeStyler.FieldShape.borderRadius,
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
    final l10n = context.l10n;
    final state = context.read<MealRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.titleMealType),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MealType.values.map((type) {
            return ChoiceChip(
              label: Text(type.label),
              showCheckmark: false,
              selected: state.mealType == type,
              onSelected: (selected) {
                if (selected) {
                  context.read<MealRegistrationBloc>().add(UpdateMealType(type));
                }
              },
              backgroundColor: ColorStyler.SurfaceContainerLow.color(context),
              selectedColor: ColorStyler.PrimaryContainer.color(context),
              labelStyle: TextStyler.Title.small(context).copyWith(
                color: state.mealType == type
                    ? ColorStyler.PrimaryContainer.onColor(context)
                    : ColorStyler.Surface.ultraLightOnColor(context),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMoodSection(BuildContext context) {
    final l10n = context.l10n;
    final state = context.read<MealRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.titleMoodBeforeMeal),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    width: 2,
                    color: state.moodBeforeMeal == mood
                        ? mood.getColor(context)
                        : ColorStyler.Surface.ultraLightOnColor(context)
                  ),
                  borderRadius: ShapeStyler.FieldShape.borderRadius,
                  color: state.moodBeforeMeal == mood
                      ? ColorStyler.PrimaryContainer.color(context)
                      : ColorStyler.SurfaceContainerLow.color(context)
                ),
                child: Icon(
                  mood.icon,
                  color: state.moodBeforeMeal == mood
                      ? mood.getColor(context)
                      : ColorStyler.Surface.ultraLightOnColor(context)
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, MealRegistrationState state) {
    final l10n = context.l10n;
    return SubmitButton(
        title: l10n.buttonSaveMealEntry,
        onPressed: () {
          context.read<MealRegistrationBloc>().add(SubmitMeal());
          context.read<NavigationBloc>().add(const NavigationEvent.pageChanged(MenuPage.log));
        },
        enabled: state.readyToSave,
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
    final l10n = context.l10n;
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
          SectionTitle(l10n.titleIngredients),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.hintEnterIngredients,
              border: ShapeStyler.InputShape.inputBorder
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
                      backgroundColor: ColorStyler.PrimaryContainer.color(context),
                      deleteIcon: const Icon(IconFacade.close, size: 18),
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

class _DescriptionSection extends StatefulWidget {
  const _DescriptionSection();

  @override
  State<_DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<_DescriptionSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<MealRegistrationBloc>().state.description ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<MealRegistrationBloc, MealRegistrationState>(
      listenWhen: (previous, current) => previous.description != current.description,
      listener: (context, state) {
        final newText = state.description ?? '';
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
          SectionTitle(l10n.titleDescriptionOptional),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.hintAddNotes,
              border: ShapeStyler.InputShape.inputBorder
            ),
            onChanged: (value) {
              context.read<MealRegistrationBloc>().add(UpdateDescription(value.isEmpty ? null : value));
            },
          ),
        ],
      ),
    );
  }
}
