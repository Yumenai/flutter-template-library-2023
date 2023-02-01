enum EnvironmentVariableData {
  production,
  userAcceptanceTest,
  systemIntegrationTest,
  development,
}

extension EnvironmentExtension on EnvironmentVariableData {
  String get hostAddress {
    switch(this) {
      case EnvironmentVariableData.production:
        return 'https://www.yumenai.com/api';
      case EnvironmentVariableData.userAcceptanceTest:
        return 'https://www.yumenai.com/api/uat';
      case EnvironmentVariableData.systemIntegrationTest:
        return 'https://www.yumenai.com/api/sit';
      case EnvironmentVariableData.development:
        return 'https://www.yumenai.com/api/development';
    }
  }
}
