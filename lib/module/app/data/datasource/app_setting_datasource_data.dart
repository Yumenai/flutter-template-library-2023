import '../../../../utility/key_value_utility.dart';
import '../../../../data/variable/environment_variable_data.dart';

const _environmentKey = 'app_environment';
const _environmentProductionValue = 1;
const _environmentUserAcceptanceTestValue = 2;
const _environmentSystemIntegrationTestValue = 3;
const _environmentDevelopmentValue = 4;

class AppSettingDatasourceData {
  const AppSettingDatasourceData();

  Future<EnvironmentVariableData?> getEnvironmentVariable() async {
    switch(await KeyValueUtility.getInt(_environmentKey)) {
      case _environmentProductionValue:
        return EnvironmentVariableData.production;
      case _environmentUserAcceptanceTestValue:
        return EnvironmentVariableData.userAcceptanceTest;
      case _environmentSystemIntegrationTestValue:
        return EnvironmentVariableData.systemIntegrationTest;
      case _environmentDevelopmentValue:
        return EnvironmentVariableData.development;
    }

    return null;
  }

  Future<bool> setEnvironmentVariable(final EnvironmentVariableData environmentVariable) {
    final int environmentCode;

    switch(environmentVariable) {
      case EnvironmentVariableData.production:
        environmentCode = _environmentProductionValue;
        break;
      case EnvironmentVariableData.userAcceptanceTest:
        environmentCode = _environmentUserAcceptanceTestValue;
        break;
      case EnvironmentVariableData.systemIntegrationTest:
        environmentCode = _environmentSystemIntegrationTestValue;
        break;
      case EnvironmentVariableData.development:
        environmentCode = _environmentDevelopmentValue;
        break;
    }

    return KeyValueUtility.setInt(_environmentKey, environmentCode);
  }


  Future<void> clear() async {
    await KeyValueUtility.clear();
  }
}