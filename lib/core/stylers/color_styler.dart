import 'package:flutter/material.dart';

enum ColorStyler {
  Primary,
  Secondary,
  Tertiary,
  PrimaryContainer,
  SecondaryContainer,
  TertiaryContainer,
  Surface,
  SurfaceContainer,
  SurfaceContainerHigh,
  SurfaceContainerHighest,
  SurfaceContainerLow,
  SurfaceContainerLowest,
  Error,
  ErrorContainer,
  Positive,
  Negative,
  Neutral,
}

extension ColorStylerExtension on ColorStyler {
  static double _lightOpacity = 0.8;
  static double _ultraLightOpacity = 0.4;

  Color color (BuildContext context) {
    switch(this) {
      case ColorStyler.Primary:
        return Theme.of(context).colorScheme.primary;
      case ColorStyler.Secondary:
        return Theme.of(context).colorScheme.secondary;
      case ColorStyler.Tertiary:
        return Theme.of(context).colorScheme.tertiary;
      case ColorStyler.PrimaryContainer:
        return Theme.of(context).colorScheme.primaryContainer;
      case ColorStyler.SecondaryContainer:
        return Theme.of(context).colorScheme.secondaryContainer;
      case ColorStyler.TertiaryContainer:
        return Theme.of(context).colorScheme.tertiaryContainer;
      case ColorStyler.Surface:
        return Theme.of(context).colorScheme.surface;
      case ColorStyler.SurfaceContainer:
        return Theme.of(context).colorScheme.surfaceContainer;
      case ColorStyler.SurfaceContainerHigh:
        return Theme.of(context).colorScheme.surfaceContainerHigh;
      case ColorStyler.SurfaceContainerHighest:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
      case ColorStyler.SurfaceContainerLow:
        return Theme.of(context).colorScheme.surfaceContainerLow;
      case ColorStyler.SurfaceContainerLowest:
        return Theme.of(context).colorScheme.surfaceContainerLowest;
      case ColorStyler.Error:
        return Theme.of(context).colorScheme.error;
      case ColorStyler.ErrorContainer:
        return Theme.of(context).colorScheme.errorContainer;
      case ColorStyler.Positive:
        return Colors.green;
      case ColorStyler.Negative:
        return Colors.red;
      case ColorStyler.Neutral:
        return Colors.white;
    }
  }

  Color onColor (BuildContext context) {
    switch(this) {
      case ColorStyler.Primary:
        return Theme.of(context).colorScheme.onPrimary;
      case ColorStyler.Secondary:
        return Theme.of(context).colorScheme.onSecondary;
      case ColorStyler.Tertiary:
        return Theme.of(context).colorScheme.onTertiary;
      case ColorStyler.PrimaryContainer:
        return Theme.of(context).colorScheme.onPrimaryContainer;
      case ColorStyler.SecondaryContainer:
        return Theme.of(context).colorScheme.onSecondaryContainer;
      case ColorStyler.TertiaryContainer:
        return Theme.of(context).colorScheme.onTertiaryContainer;
      case ColorStyler.Surface:
      case ColorStyler.SurfaceContainer:
      case ColorStyler.SurfaceContainerHigh:
      case ColorStyler.SurfaceContainerHighest:
      case ColorStyler.SurfaceContainerLow:
      case ColorStyler.SurfaceContainerLowest:
        return Theme.of(context).colorScheme.onSurface;
      case ColorStyler.Error:
        return Theme.of(context).colorScheme.onError;
      case ColorStyler.ErrorContainer:
        return Theme.of(context).colorScheme.onErrorContainer;
      case ColorStyler.Positive:
        return Colors.white;
      case ColorStyler.Negative:
        return Colors.white;
      case ColorStyler.Neutral:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color lightColor (BuildContext context) {
    return color(context).withValues(alpha: _lightOpacity);
  }

  Color lightOnColor (BuildContext context) {
    return onColor(context).withValues(alpha: _lightOpacity);
  }

  Color ultraLightColor (BuildContext context) {
    return color(context).withValues(alpha: _ultraLightOpacity);
  }

  Color ultraLightOnColor (BuildContext context) {
    return onColor(context).withValues(alpha: _ultraLightOpacity);
  }

  Color scaledColor (BuildContext context, {double ratio = 1.0, double? aRatio, double? rRatio, double? gRatio, double? bRatio}) {
    Color base = color(context);
    return base.withValues(
        alpha: base.a * (aRatio ?? ratio),
        red: base.r * (rRatio ?? ratio),
        green: base.g * (gRatio ?? ratio),
        blue: base.b * (bRatio ?? ratio)
    );
  }

  Color scaledOnColor (BuildContext context, {double ratio = 1.0, double? aRatio, double? rRatio, double? gRatio, double? bRatio}) {
    Color base = onColor(context);
    return base.withValues(
        alpha: base.a * (aRatio ?? ratio),
        red: base.r * (rRatio ?? ratio),
        green: base.g * (gRatio ?? ratio),
        blue: base.b * (bRatio ?? ratio)
    );
  }
}
