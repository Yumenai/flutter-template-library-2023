import 'package:flutter/material.dart';

enum EnvironmentData {
  production('PROD', Colors.green),
  userAcceptanceTest('UAT', Colors.blue),
  systemIntegrationTest('SIT', Colors.orange),
  development('DEV', Colors.red);

  final Color color;
  final String code;

  const EnvironmentData(this.code, this.color);
}
