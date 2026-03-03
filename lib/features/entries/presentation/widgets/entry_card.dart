import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/core/entities/symptom.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/stylers/text_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/features/entries/presentation/bloc/entry_bloc.dart';
import 'package:scheck/l10n/l10n.dart';

class EntryCard extends StatefulWidget {
  final Entry entry;

  const EntryCard({super.key, required this.entry});

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
      /*color: (widget.entry is MealEntry)
          ? ColorStyler.PrimaryContainer.ultraLightColor(context)
          : ColorStyler.ErrorContainer.ultraLightColor(context),
      shadowColor: (widget.entry is MealEntry)
          ? ColorStyler.PrimaryContainer.ultraLightColor(context)
          : ColorStyler.ErrorContainer.ultraLightColor(context),*/
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
                    _buildHeader(context),
                    const SizedBox(height: 12),
                    if (widget.entry is MealEntry) _buildMealDetails(context, widget.entry as MealEntry),
                    if (widget.entry is SymptomEntry) _buildSymptomDetails(context, widget.entry as SymptomEntry),
                    if (widget.entry.description != null) ...[
                      const SizedBox(height: 12),
                      _buildDescription(context),
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
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _showEntryDetailsDialog(context, widget.entry),
                    child: ColoredBox(
                        color: ColorStyler.PrimaryContainer.color(context),
                        child: Center(
                            child: Text(l10n.buttonInfo,
                                style: TextStyler.Body.medium(context)
                                    .copyWith(color: ColorStyler.PrimaryContainer.onColor(context))))),
                  ),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () => DialogHandler.showConfirmDialog(context, l10n.dialogConfirmDeleteEntry).then(
                          (confirmed) {
                        if (confirmed == true) {
                          context.read<EntryBloc>().add(DeleteEntryEvent(widget.entry));
                          setState(() {
                            _showBottomMenu = false;
                          });
                        }
                      }),
                      child: ColoredBox(
                          color: ColorStyler.ErrorContainer.color(context),
                          child: Center(
                              child: Text(l10n.buttonDelete,
                                  style: TextStyler.Body.medium(context)
                                      .copyWith(color: ColorStyler.ErrorContainer.onColor(context)))))),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEntryDetailsDialog(BuildContext context, Entry entry) {
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(DateFormat.yMMMd().add_jm().format(entry.timestamp)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.detailsDialogIdLabel(entry.id)),
            if (entry is SymptomEntry) ...[
              Text(l10n.detailsDialogSymptomsLabel(entry.symptoms
                  .map((key) => Symptom.values.firstWhere((s) => s.key == key).getLabel(l10n))
                  .join(', '))),
              Text(l10n.detailsDialogIntensitiesLabel(entry.symptomIntensities.toString())),
            ],
            if (entry is MealEntry) ...[
              Text(l10n.detailsDialogMealLabel(entry.mealType.label)),
              Text(l10n.detailsDialogImageLabel(entry.localImageUrl ?? entry.remoteImageUrl ?? context.l10n.detailsDialogNoImage)),
              Row(
                children: [
                  Text(l10n.detailsDialogMoodLabel),
                  Icon(entry.moodBeforeMeal?.icon ?? IconFacade.empty, size: 20),
                  Text(entry.moodBeforeMeal?.label ?? l10n.generalNotAvailable),
                ],
              ),
              Text(l10n.detailsDialogIngredientsLabel(entry.ingredients.join(", "))),
            ],
            if (entry.description != null) Text(l10n.detailsDialogDescriptionLabel(entry.description!)),
          ],
        ),
        actions: [
          TextButton(
            child: Text(l10n.buttonClose),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: Text(l10n.buttonDelete),
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

  Widget _buildHeader(BuildContext context) {
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
        _buildEntryTypeIcon(context),
      ],
    );
  }

  Widget _buildEntryIcon(
      {required IconData icon, required Color foregroundColor, required Color backgroundColor}) {
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

  Widget _buildEntryTypeIcon(BuildContext context) {
    if (widget.entry is MealEntry) {
      return _buildEntryIcon(
          icon: IconFacade.meal,
          foregroundColor: ColorStyler.Primary.color(context),
          backgroundColor: ColorStyler.PrimaryContainer.color(context));
    } else {
      return _buildEntryIcon(
          icon: IconFacade.symptom,
          foregroundColor: ColorStyler.Error.color(context),
          backgroundColor: ColorStyler.ErrorContainer.color(context));
    }
  }

  Widget _noImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: ColorStyler.ErrorContainer.color(context),
        borderRadius: ShapeStyler.FieldShape.borderRadius,
      ),
      child: Center(
        child: Icon(
          IconFacade.noImage,
          size: 40,
          color: ColorStyler.ErrorContainer.onColor(context),
        ),
      ),
    );
  }

  Widget _buildMealImage(MealEntry mealEntry) {
    final localFile = File(mealEntry.localImageUrl ?? '');
    if(mealEntry.localImageUrl != null && localFile.existsSync()) {
      return Image.file(
        localFile,
        width: double.infinity,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _noImage(context),
      );
    }

    if(mealEntry.remoteImageUrl != null) {
      return Image.network(
        mealEntry.remoteImageUrl!,
        width: double.infinity,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _noImage(context),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      );
    }

    return _noImage(context);
  }

  Widget _buildMealDetails(BuildContext context, MealEntry mealEntry) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(label: l10n.titleMealType, value: Text(mealEntry.mealType.label)),
        _buildMealImage(mealEntry),
        const SizedBox(height: 8),
        if (mealEntry.ingredients.isNotEmpty) ...[
          _buildInfoRow(label: l10n.titleIngredients, value: Text(mealEntry.ingredients.join(', '))),
        ],
        if (mealEntry.moodBeforeMeal != null) _buildMoodRow(context, mealEntry.moodBeforeMeal!),
      ],
    );
  }

  Widget _buildMoodRow(BuildContext context, Mood mood) {
    return _buildInfoRow(
        label: context.l10n.titleMood,
        value: Row(
          children: [
            Icon(
              mood.icon,
              color: mood.getColor(context),
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              mood.label,
              style: TextStyler.Body.medium(context).copyWith(color: mood.getColor(context)),
            ),
          ],
        ));
  }

  Widget _buildSymptomDetails(BuildContext context, SymptomEntry symptomEntry) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ...symptomEntry.symptoms.map((symptomKey) {
          final symptom = Symptom.values.firstWhere((s) => s.key == symptomKey);
          final intensity = symptomEntry.symptomIntensities[symptomKey] ?? 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      symptom.getLabel(l10n),
                      style: TextStyler.Title.medium(context),
                    ),
                    Text(
                      l10n.labelIntensityShort(intensity),
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

  Widget _buildDescription(BuildContext context) {
    final l10n = context.l10n;
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
            l10n.titleNotes,
            style: TextStyler.Title.small(context)
                .copyWith(color: ColorStyler.SurfaceContainerHigh.ultraLightOnColor(context)),
          ),
          const SizedBox(height: 4),
          Text(widget.entry.description!,
              style: TextStyler.Body.small(context)
                  .copyWith(color: ColorStyler.SurfaceContainerHigh.lightOnColor(context))),
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
        Expanded(child: value),
      ],
    );
  }
}
