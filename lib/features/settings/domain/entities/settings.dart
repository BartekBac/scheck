import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
sealed class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('en') String locale,
    @Default(0xFF3F51B5) int primaryColor, // Default to Colors.indigo
  }) = _AppSettings;
}
