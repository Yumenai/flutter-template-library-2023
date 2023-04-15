import 'package:flutter/material.dart';

import '../../data/configuration_data.dart';
import '../../data/variable/environment_variable_data.dart';
import 'datasource/app_setting_datasource.dart';

class AppRepository {
  static const _settingSourceData = AppSettingDatasource();

  static Future<AppRepository> initialise() async {
    final languageCode = await _settingSourceData.getLanguageCode();

    return AppRepository._(
      locale: languageCode.isEmpty ?  ConfigurationData.defaultLocale : Locale(languageCode),
      themeMode: await _settingSourceData.getThemeMode(),
      environmentVariable: await _settingSourceData.getEnvironmentVariable() ?? EnvironmentVariableData.development,
      sessionAccessToken: await _settingSourceData.getSessionAccessToken(),
      sessionRefreshToken: await _settingSourceData.getSessionRefreshToken(),
    );
  }

  Locale? _locale;
  Locale get locale => _locale ?? ConfigurationData.defaultLocale;
  set locale(locale) {
    _locale = locale;
    _settingSourceData.setLanguageCode(locale.languageCode);
  }

  ThemeMode? _themeMode;
  ThemeMode get themeMode => _themeMode ?? ConfigurationData.defaultThemeMode;
  set themeMode(themeMode) {
    _themeMode = themeMode;
    _settingSourceData.setThemeMode(themeMode);
  }

  EnvironmentVariableData? _environmentVariable;
  EnvironmentVariableData get environmentVariable => _environmentVariable ?? ConfigurationData.defaultEnvironment;
  set environmentVariable(environmentVariable) {
    _environmentVariable = environmentVariable;
    _settingSourceData.setEnvironmentVariable(environmentVariable);
  }

  String? _sessionAccessToken;
  String get sessionAccessToken => _sessionAccessToken ?? '';
  set sessionAccessToken(sessionAccessToken) {
    _sessionAccessToken = sessionAccessToken;
    _settingSourceData.setSessionAccessToken(sessionAccessToken);
  }

  String? _sessionRefreshToken;
  String get sessionRefreshToken => _sessionRefreshToken ?? '';
  set sessionRefreshToken(sessionRefreshToken) {
    _sessionRefreshToken = sessionRefreshToken;
    _settingSourceData.setSessionRefreshToken(sessionRefreshToken);
  }

  AppRepository._({
    required final Locale? locale,
    required final ThemeMode? themeMode,
    required final EnvironmentVariableData? environmentVariable,
    required final String sessionAccessToken,
    required final String sessionRefreshToken,
  }) :  _locale = locale,
        _themeMode = themeMode,
        _environmentVariable = environmentVariable,
        _sessionAccessToken = sessionAccessToken,
        _sessionRefreshToken = sessionRefreshToken;

  Future<void> clear() async {
    _locale = null;
    _themeMode = null;
    _environmentVariable = null;
    _sessionAccessToken = '';
    _sessionRefreshToken = '';

    await _settingSourceData.clear();
  }
}