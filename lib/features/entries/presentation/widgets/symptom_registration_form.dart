import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/core/entities/symptom.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/stylers/text_styler.dart';
import 'package:scheck/core/utils/error_handler.dart';
import 'package:scheck/core/widgets/section_title.dart';
import 'package:scheck/core/widgets/submit_button.dart';
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart';
import 'package:scheck/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class SymptomRegistrationForm extends StatelessWidget {
  const SymptomRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SymptomRegistrationBloc, SymptomRegistrationState>(
      builder: (context, state) {
        return BlocListener<SymptomRegistrationBloc, SymptomRegistrationState>(
          listenWhen: (prev, curr) => curr.status == SymptomRegistrationStatus.error,
          listener: (context, state) {
            if (state.error != null) {
              ErrorHandler.showAtSnackBar(context, state.error!.getMessage(l10n));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSymptomsSection(context, l10n),
                const SizedBox(height: 24),
                if (state.selectedSymptoms.isNotEmpty) ...[
                  _buildIntensitySection(context, l10n),
                  const SizedBox(height: 24),
                ],
                _buildDescriptionSection(context, l10n),
                const SizedBox(height: 24),
                _buildSubmitButton(context, state, l10n),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSymptomsSection(BuildContext context, AppLocalizations l10n) {
    final state = context.read<SymptomRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.titleSelectSymptoms),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: Symptom.values.map((symptom) {
            final isSelected = state.selectedSymptoms.contains(symptom.key);
            return FilterChip(
              label: Text(symptom.getLabel(l10n)),
              selected: isSelected,
              onSelected: (selected) {
                context.read<SymptomRegistrationBloc>().add(SelectSymptoms(symptom.key));
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

  Widget _buildIntensitySection(BuildContext context, AppLocalizations l10n) {
    final state = context.read<SymptomRegistrationBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.titleSetIntensity),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.selectedSymptoms.length,
          itemBuilder: (context, index) {
            final symptomKey = state.selectedSymptoms[index];
            final symptom = Symptom.values.firstWhere((s) => s.key == symptomKey);
            final intensity = state.symptomIntensities[symptomKey] ?? 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        symptom.getLabel(l10n),
                        style: TextStyler.Title.small(context),
                      ),
                      Text(
                        l10n.labelIntensity(intensity),
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
                            UpdateSymptomIntensity(symptomKey, value.round()),
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

  Widget _buildDescriptionSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.titleDescriptionOptional),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            focusedBorder: ShapeStyler.InputShape.inputBorder.copyWith(
                borderSide: BorderSide(color: ColorStyler.Error.color(context), width: 2)),
            hintText: l10n.hintAddNotes,
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

  Widget _buildSubmitButton(
      BuildContext context, SymptomRegistrationState state, AppLocalizations l10n) {
    return SubmitButton(
      title: l10n.buttonSaveSymptomEntry,
      onPressed: () {
        context.read<SymptomRegistrationBloc>().add(SubmitSymptoms());
        context.read<NavigationBloc>().add(const NavigationEvent.pageChanged(MenuPage.log));
      },
      colorStyler: ColorStyler.Error,
      enabled: state.readyToSave,
    );
  }
}
