import 'package:injectable/injectable.dart';
import 'package:scheck/features/settings/domain/entities/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SettingsLocalDataSource {
  static const _localeKey = 'settings_locale';
  static const _colorKey = 'settings_primary_color';

  Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString(_localeKey) ?? 'en';
    final color = prefs.getInt(_colorKey) ?? 0xFFFFA500;
    return AppSettings(locale: locale, primaryColor: color);
  }

  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, settings.locale);
    await prefs.setInt(_colorKey, settings.primaryColor);
  }
}
