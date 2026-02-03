import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheck/features/entries/presentation/pages/symptom_registration_page.dart';

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
        const Text(
          'Select Symptoms',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
              selectedColor: Colors.red[100],
              backgroundColor: Colors.grey[200],
              checkmarkColor: Colors.red,
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
        const Text(
          'Set Intensity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Intensity: $intensity/10',
                        style: const TextStyle(color: Colors.grey),
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
                    activeColor: Colors.red,
                  ),
                  Row(
                    children: List.generate(5, (i) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 4,
                          decoration: BoxDecoration(
                            color: i < (intensity / 2) ? Colors.red : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
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
        const Text(
          'Description (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any additional notes about your symptoms...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
    return ElevatedButton(
      onPressed: state.selectedSymptoms.isNotEmpty
          ? () {
              context.read<SymptomRegistrationBloc>().add(SubmitSymptoms());
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Save Symptom Entry',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}