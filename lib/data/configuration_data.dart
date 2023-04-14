import 'package:flutter/material.dart';

import 'variable/environment_variable_data.dart';
import 'resource/language_resource_data.dart';

class ConfigurationData {
  static const hostAddressProduction = 'https://www.yumenai.com/api';
  static const hostAddressUserAcceptanceTest = 'https://www.yumenai.com/api/uat';
  static const hostAddressSystemIntegrationTest = 'https://www.yumenai.com/api/sit';
  static const hostAddressDevelopment = 'https://www.yumenai.com/api/development';

  static const defaultHostAddress = hostAddressDevelopment;

  static const defaultThemeMode = ThemeMode.system;

  static const defaultEnvironment = EnvironmentVariableData.development;

  static final defaultLocalizationDelegate = LanguageResourceData.localizationDelegateList.first;

  static final defaultLocale = LanguageResourceData.supportedLocaleList.first;

  static bool get isDevelopmentMode => true;

  const ConfigurationData._();
}
