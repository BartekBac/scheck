import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/stylers/text_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
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
        borderRadius: ShapeStyler.FieldShape.borderRadius,
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
            child: Row(children: [
              Expanded(child: InkWell(
                onTap: () => _showEntryDetailsDialog(context, widget.entry),
                child: ColoredBox(
                    color: ColorStyler.PrimaryContainer.color(context),
                    child: Center(child: Text('Info', style: TextStyler.Body.medium(context).copyWith(color: ColorStyler.PrimaryContainer.onColor(context)))
                )
              ))),
              Expanded(child: InkWell(
                onTap: () => DialogHandler.showConfirmDialog(context, 'Are you sure you want to delete this entry?')
                    .then(
                        (confirmed) {
                          if (confirmed) {
                            context.read<EntryBloc>().add(DeleteEntryEvent(
                                widget.entry));
                            setState(() {
                              _showBottomMenu = false;
                            });
                          }
                        }
                    ),
                child: ColoredBox(
                    color: ColorStyler.ErrorContainer.color(context),
                    child: Center(child: Text('Delete', style: TextStyler.Body.medium(context).copyWith(color: ColorStyler.ErrorContainer.onColor(context)))))
              ))
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
                    entry.moodBeforeMeal?.icon ?? IconFacade.empty,
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
              foregroundColor: ColorStyler.Error.color(context),
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
              style: TextStyler.Title.large(context).copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              dateFormat.format(widget.entry.timestamp),
              style: TextStyler.Body.medium(context).copyWith(color: ColorStyler.Surface.lightOnColor(context)),
            ),
          ],
        ),
        _buildEntryTypeIcon(),
      ],
    );
  }

  Widget _buildEntryIcon({
    required IconData icon,
    required Color foregroundColor,
    required Color backgroundColor})
  {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: ShapeStyler.FieldShape.borderRadius,
      ),
      child: Icon(
        icon,
        color: foregroundColor,
        size: 24,
      ),
    );
  }

  Widget _buildEntryTypeIcon() {
    if (widget.entry is MealEntry) {
      return _buildEntryIcon(
          icon: IconFacade.meal,
          foregroundColor: ColorStyler.Primary.color(context),
          backgroundColor: ColorStyler.PrimaryContainer.color(context)
      );
    } else {
      return _buildEntryIcon(
          icon: IconFacade.symptom,
          foregroundColor: ColorStyler.Error.color(context),
          backgroundColor: ColorStyler.ErrorContainer.color(context)
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
        _buildInfoRow(label: 'Meal Type', value: Text(mealEntry.mealType.label)),
        _buildMealImage(mealEntry),
        const SizedBox(height: 8),
        if (mealEntry.ingredients.isNotEmpty) ...[
          _buildInfoRow(label: 'Ingredients', value: Text(mealEntry.ingredients.join(', '))),
        ],
        if (mealEntry.moodBeforeMeal != null)
          _buildMoodRow(mealEntry.moodBeforeMeal!),
      ],
    );
  }

  Widget _buildMoodRow(Mood mood) {
    return _buildInfoRow(
        label: 'Mood',
        value: Row(
          children: [
            Icon(mood.icon,
              color: mood.getColor(context),
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(mood.label,
              style: TextStyler.Body.medium(context).copyWith(color: mood.getColor(context)),
            ),
          ],
        )
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
                      style: TextStyler.Title.medium(context),
                    ),
                    Text(
                      '$intensity/10',
                      style: TextStyler.Title.medium(context).copyWith(color: ColorStyler.Error.lightColor(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: intensity / 10,
                  backgroundColor: ColorStyler.ErrorContainer.lightColor(context),
                  valueColor: AlwaysStoppedAnimation<Color>(ColorStyler.Error.color(context)),
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
        color: ColorStyler.SurfaceContainerHigh.color(context),
        borderRadius: ShapeStyler.InnerFieldShape.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Notes',
            style: TextStyler.Title.small(context).copyWith(color: ColorStyler.SurfaceContainerHigh.ultraLightOnColor(context)),
          ),
          const SizedBox(height: 4),
          Text(widget.entry.description!, style: TextStyler.Body.small(context).copyWith(color: ColorStyler.SurfaceContainerHigh.lightOnColor(context))),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String label, required Widget value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyler.Label.large(context),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: value,
        ),
      ],
    );
  }
}