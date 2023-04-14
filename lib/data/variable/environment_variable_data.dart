import 'package:flutter/material.dart';

enum EnvironmentVariableData {
  production('PROD', Colors.green),
  userAcceptanceTest('UAT', Colors.blue),
  systemIntegrationTest('SIT', Colors.orange),
  development('DEV', Colors.red);

  final Color color;
  final String code;

  const EnvironmentVariableData(this.code, this.color);
}
