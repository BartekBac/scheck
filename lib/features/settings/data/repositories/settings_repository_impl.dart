import 'package:injectable/injectable.dart';
import 'package:scheck/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:scheck/features/settings/domain/entities/settings.dart';
import 'package:scheck/features/settings/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  Future<AppSettings> getSettings() async {
    return _localDataSource.getSettings();
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _localDataSource.saveSettings(settings);
  }
}
