import 'package:flutter/material.dart';

enum TextStyler {
  Display,
  Headline,
  Title,
  Label,
  Body
}

extension TextStylerExtension on TextStyler {
  static TextStyle _default = TextStyle();

  TextStyle large (BuildContext context) {
    switch(this) {
      case TextStyler.Display:
        return Theme.of(context).textTheme.displayLarge ?? _default;
      case TextStyler.Headline:
        return Theme.of(context).textTheme.headlineLarge ?? _default;
      case TextStyler.Title:
        return Theme.of(context).textTheme.titleLarge ?? _default;
      case TextStyler.Label:
        return Theme.of(context).textTheme.labelLarge ?? _default;
      case TextStyler.Body:
        return Theme.of(context).textTheme.bodyLarge ?? _default;
    }
  }

  TextStyle medium (BuildContext context) {
    switch(this) {
      case TextStyler.Display:
        return Theme.of(context).textTheme.displayMedium ?? _default;
      case TextStyler.Headline:
        return Theme.of(context).textTheme.headlineMedium ?? _default;
      case TextStyler.Title:
        return Theme.of(context).textTheme.titleMedium ?? _default;
      case TextStyler.Label:
        return Theme.of(context).textTheme.labelMedium ?? _default;
      case TextStyler.Body:
        return Theme.of(context).textTheme.bodyMedium ?? _default;
    }
  }

  TextStyle small (BuildContext context) {
    switch(this) {
      case TextStyler.Display:
        return Theme.of(context).textTheme.displaySmall ?? _default;
      case TextStyler.Headline:
        return Theme.of(context).textTheme.headlineSmall ?? _default;
      case TextStyler.Title:
        return Theme.of(context).textTheme.titleSmall ?? _default;
      case TextStyler.Label:
        return Theme.of(context).textTheme.labelSmall ?? _default;
      case TextStyler.Body:
        return Theme.of(context).textTheme.bodySmall ?? _default;
    }
  }
}
