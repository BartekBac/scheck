import 'package:injectable/injectable.dart';
import 'package:scheck/features/settings/domain/entities/settings.dart';
import 'package:scheck/features/settings/domain/repositories/settings_repository.dart';

@lazySingleton
class GetSettings {
  final SettingsRepository _repository;

  GetSettings(this._repository);

  Future<AppSettings> call() {
    return _repository.getSettings();
  }
}
