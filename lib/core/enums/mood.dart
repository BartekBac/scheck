import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/utils/icon_facade.dart';
import 'package:scheck/l10n/l10n.dart';

enum Mood {
  great,
  good,
  neutral,
  bad,
  terrible,
}

extension MoodExtension on Mood {
  IconData get icon => switch(this) {
    Mood.great => IconFacade.great,
    Mood.good => IconFacade.good,
    Mood.neutral => IconFacade.neutral,
    Mood.bad => IconFacade.bad,
    Mood.terrible => IconFacade.terrible
  };

  String getLabel(BuildContext context) => switch(this) {
    Mood.great => context.l10n.moodGreat,
    Mood.good => context.l10n.moodGood,
    Mood.neutral => context.l10n.moodNeutral,
    Mood.bad => context.l10n.moodBad,
    Mood.terrible => context.l10n.moodTerrible
  };

  Color getColor(BuildContext context) => switch(this) {
    Mood.great => ColorStyler.Positive.color(context),
    Mood.good => ColorStyler.Positive.scaledColor(context, ratio: 0.8),
    Mood.neutral => ColorStyler.Surface.scaledOnColor(context, ratio: 0.6),
    Mood.bad => ColorStyler.Negative.scaledColor(context, ratio: 0.8),
    Mood.terrible => ColorStyler.Negative.color(context),
  };
}
