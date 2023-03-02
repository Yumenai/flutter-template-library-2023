import 'package:flutter/material.dart';

enum EnvironmentVariableData {
  production,
  userAcceptanceTest,
  systemIntegrationTest,
  development,
}

extension EnvironmentExtension on EnvironmentVariableData {
  String get code {
    switch(this) {
      case EnvironmentVariableData.production:
        return 'PROD';
      case EnvironmentVariableData.userAcceptanceTest:
        return 'UAT';
      case EnvironmentVariableData.systemIntegrationTest:
        return 'SIT';
      case EnvironmentVariableData.development:
        return 'DEV';
    }
  }

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

  Color get color {
    switch(this) {
      case EnvironmentVariableData.production:
        return Colors.green;
      case EnvironmentVariableData.userAcceptanceTest:
        return Colors.blue;
      case EnvironmentVariableData.systemIntegrationTest:
        return Colors.orange;
      case EnvironmentVariableData.development:
        return Colors.red;
    }
  }
}
