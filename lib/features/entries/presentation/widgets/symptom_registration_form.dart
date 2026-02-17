import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/stylers/text_styler.dart';
import 'package:scheck/core/widgets/section_title.dart';
import 'package:scheck/core/widgets/submit_button.dart';
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart';
import 'package:scheck/features/navigation/presentation/bloc/navigation_bloc.dart';

class SymptomRegistrationForm extends StatelessWidget {
  const SymptomRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymptomRegistrationBloc, SymptomRegistrationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSymptomsSection(context),
              const SizedBox(height: 24),
              if (state.selectedSymptoms.isNotEmpty) ...[
                _buildIntensitySection(context),
                const SizedBox(height: 24),
              ],
              _buildDescriptionSection(context),
              const SizedBox(height: 24),
              _buildSubmitButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSymptomsSection(BuildContext context) {
    final state = context.read<SymptomRegistrationBloc>().state;
    final commonSymptoms = [
      'Abdominal pain',
      'Bloating',
      'Nausea',
      'Heartburn',
      'Diarrhea',
      'Constipation',
      'Fatigue',
      'Headache',
      'Joint pain',
      'Skin rash',
      'Anxiety',
      'Brain fog',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Select Symptoms'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: commonSymptoms.map((symptom) {
            final isSelected = state.selectedSymptoms.contains(symptom);
            return FilterChip(
              label: Text(symptom),
              selected: isSelected,
              onSelected: (selected) {
                context.read<SymptomRegistrationBloc>().add(SelectSymptoms(symptom));
              },
              selectedColor: ColorStyler.ErrorContainer.color(context),
              backgroundColor: ColorStyler.SurfaceContainerLow.color(context),
              checkmarkColor: ColorStyler.Error.color(context),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildIntensitySection(BuildContext context) {
    final state = context.read<SymptomRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Set Intensity'),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.selectedSymptoms.length,
          itemBuilder: (context, index) {
            final symptom = state.selectedSymptoms[index];
            final intensity = state.symptomIntensities[symptom] ?? 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        symptom,
                        style: TextStyler.Title.small(context),
                      ),
                      Text(
                        'Intensity: $intensity/10',
                        style: TextStyler.Title.small(context).copyWith(color: ColorStyler.Error.lightColor(context)),
                      ),
                    ],
                  ),
                  Slider(
                    value: intensity.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (value) {
                      context.read<SymptomRegistrationBloc>().add(
                        UpdateSymptomIntensity(symptom, value.round()),
                      );
                    },
                    activeColor: ColorStyler.Error.color(context),
                  ),
                  Row(
                    children: List.generate(5, (i) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 4,
                          decoration: BoxDecoration(
                            color: i < (intensity / 2)
                                ? ColorStyler.Error.color(context)
                                : ColorStyler.ErrorContainer.lightColor(context),
                            borderRadius: ShapeStyler.FieldShape.borderRadius,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Description (Optional)'),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            focusedBorder: ShapeStyler.InputShape.inputBorder.copyWith(
                borderSide: BorderSide(color: ColorStyler.Error.color(context), width: 2)
            ),
            hintText: 'Add any additional notes...',
            border: ShapeStyler.InputShape.inputBorder,
          ),
          onChanged: (value) {
            context.read<SymptomRegistrationBloc>().add(
              UpdateDescription(value.isEmpty ? null : value),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, SymptomRegistrationState state) {
    return SubmitButton(
        title: 'Save Symptom Entry',
        onPressed: () {
          context.read<SymptomRegistrationBloc>().add(SubmitSymptoms());
          context.read<NavigationBloc>().add(const NavigationEvent.pageChanged(MenuPage.log));
        },
        colorStyler: ColorStyler.Error,
        enabled: state.readyToSave,
    );
  }
}