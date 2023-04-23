import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'variable/environment_variable_data.dart';

class ConfigurationData {
  static const hostAddressProduction = 'https://www.yumenai.com/api';
  static const hostAddressUserAcceptanceTest = 'https://www.yumenai.com/api/uat';
  static const hostAddressSystemIntegrationTest = 'https://www.yumenai.com/api/sit';
  static const hostAddressDevelopment = 'https://www.yumenai.com/api/development';

  static const localizationDelegateList = AppLocalizations.localizationsDelegates;

  static const supportedLocaleList = AppLocalizations.supportedLocales;

  static const defaultHostAddress = hostAddressDevelopment;

  static const defaultThemeMode = ThemeMode.system;

  static const defaultEnvironment = EnvironmentVariableData.development;

  static final defaultLocalizationDelegate = localizationDelegateList.first;

  static final defaultLocale = supportedLocaleList.first;

  static bool get isTestMode => true;

  static bool get isMockedData => true;

  const ConfigurationData._();
}
