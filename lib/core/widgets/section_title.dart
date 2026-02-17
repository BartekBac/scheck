import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/text_styler.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final Color? color;
  const SectionTitle(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyler.Title.medium(context).copyWith(color: color),
    );
  }
}
