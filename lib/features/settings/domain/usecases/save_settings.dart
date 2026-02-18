import 'package:injectable/injectable.dart';
import 'package:scheck/features/settings/domain/entities/settings.dart';
import 'package:scheck/features/settings/domain/repositories/settings_repository.dart';

@lazySingleton
class SaveSettings {
  final SettingsRepository _repository;

  SaveSettings(this._repository);

  Future<void> call(AppSettings settings) {
    return _repository.saveSettings(settings);
  }
}
