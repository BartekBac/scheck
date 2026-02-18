import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scheck/features/settings/domain/entities/settings.dart';
import 'package:scheck/features/settings/domain/usecases/get_settings.dart';
import 'package:scheck/features/settings/domain/usecases/save_settings.dart';

part 'settings_bloc.freezed.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.load() = _LoadSettings;
  const factory SettingsEvent.changeLanguage(String locale) = _ChangeLanguage;
  const factory SettingsEvent.changePrimaryColor(int color) = _ChangePrimaryColor;
}

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool isLoading,
    AppSettings? settings,
  }) = _SettingsState;
}

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings _getSettings;
  final SaveSettings _saveSettings;

  SettingsBloc(this._getSettings, this._saveSettings) : super(const _SettingsState()) {
    on<_LoadSettings>(_onLoadSettings);
    on<_ChangeLanguage>(_onChangeLanguage);
    on<_ChangePrimaryColor>(_onChangePrimaryColor);
  }

  Future<void> _onLoadSettings(
    _LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final settings = await _getSettings();
    emit(state.copyWith(isLoading: false, settings: settings));
  }

  Future<void> _onChangeLanguage(
    _ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null) return;
    final newSettings = state.settings!.copyWith(locale: event.locale);
    await _saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> _onChangePrimaryColor(
    _ChangePrimaryColor event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.settings == null) return;
    final newSettings = state.settings!.copyWith(primaryColor: event.color);
    await _saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }
}
