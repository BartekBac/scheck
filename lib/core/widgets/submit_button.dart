import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/stylers/shape_styler.dart';
import 'package:scheck/core/widgets/section_title.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({required this.title, this.onPressed, this.colorStyler = ColorStyler.Primary, this.enabled = true, super.key});

  final String title;
  final VoidCallback? onPressed;
  final ColorStyler colorStyler;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: enabled
            ? onPressed
            : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: colorStyler.color(context),
            foregroundColor: colorStyler.onColor(context),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: ShapeStyler.ButtonShape.outlinedBorder
        ),
        child: SectionTitle(
          title,
          color: enabled
              ? colorStyler.onColor(context)
              : ColorStyler.Surface.ultraLightOnColor(context),
        )
    );
  }
}
