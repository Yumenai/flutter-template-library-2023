import 'variable/environment_variable_data.dart';

class AppData {
  static String get hostAddress => _environment.hostAddress;

  static EnvironmentVariableData _environment = EnvironmentVariableData.development;

  static void updateEnvironment({
    final bool toProduction = false,
    final bool toUserAcceptanceTest = false,
    final bool toSystemIntegrationTest = false,
    final bool toDevelopment = false,
  }) {
    if (toProduction) {
      _environment = EnvironmentVariableData.production;
    } else if (toUserAcceptanceTest) {
      _environment = EnvironmentVariableData.userAcceptanceTest;
    } else if (toSystemIntegrationTest) {
      _environment = EnvironmentVariableData.systemIntegrationTest;
    } else if (toDevelopment) {
      _environment = EnvironmentVariableData.development;
    }
  }

  const AppData._();
}
