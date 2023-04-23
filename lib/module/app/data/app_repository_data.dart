import '../../../data/variable/environment_variable_data.dart';
import 'datasource/app_setting_datasource_data.dart';

class AppRepositoryData {
  final _settingDatasource = const AppSettingDatasourceData();

  const AppRepositoryData();

  Future<EnvironmentVariableData?> getEnvironment() async {
    return _settingDatasource.getEnvironmentVariable();
  }

  Future<void> setEnvironment(final EnvironmentVariableData? environment) async {
    if (environment == null) return;

    await _settingDatasource.setEnvironmentVariable(environment);
  }

  Future<void> clear() async {
    await _settingDatasource.clear();
  }
}
