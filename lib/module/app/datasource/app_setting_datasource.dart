import 'package:flutter/material.dart';

import '../../../utility/key_value_utility.dart';
import '../../../data/variable/environment_variable_data.dart';

const _themeKey = 'theme';
const _themeDarkValue = 1;
const _themeLightValue = 2;
const _themeSystemValue = 3;

const _languageKey = 'app-language';

const _environmentKey = 'app-environment';
const _environmentProductionValue = 1;
const _environmentUserAcceptanceTestValue = 2;
const _environmentSystemIntegrationTestValue = 3;
const _environmentDevelopmentValue = 4;

const _sessionAccessTokenKey = 'session_access_token';
const _sessionRefreshTokenKey = 'session_refresh_token';

class AppSettingDatasource {
  const AppSettingDatasource();

  Future<ThemeMode?> getThemeMode() async {
    switch(await KeyValueUtility.getInt(_themeKey)) {
      case _themeDarkValue:
        return ThemeMode.dark;
      case _themeLightValue:
        return ThemeMode.light;
      case _themeSystemValue:
        return ThemeMode.system;
    }

    return null;
  }

  Future<String> getLanguageCode() async {
    return await KeyValueUtility.getString(_languageKey) ?? '';
  }

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

  Future<String> getSessionAccessToken() async {
    return await KeyValueUtility.getString(_sessionAccessTokenKey) ?? '';
  }

  Future<String> getSessionRefreshToken() async {
    return await KeyValueUtility.getString(_sessionRefreshTokenKey) ?? '';
  }



  Future<bool> setThemeMode(final ThemeMode themeMode) {
    final int themeCode;

    switch(themeMode) {
      case ThemeMode.dark:
        themeCode = _themeDarkValue;
        break;
      case ThemeMode.light:
        themeCode = _themeLightValue;
        break;
      case ThemeMode.system:
        themeCode = _themeSystemValue;
        break;
    }

    return KeyValueUtility.setInt(_themeKey, themeCode);
  }

  Future<bool> setLanguageCode(final String languageCode) {
    return KeyValueUtility.setString(_languageKey, languageCode);
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

    return KeyValueUtility.setInt(_themeKey, environmentCode);
  }

  Future<bool> setSessionAccessToken(final String accessToken) {
    return KeyValueUtility.setString(_sessionAccessTokenKey, accessToken);
  }

  Future<bool> setSessionRefreshToken(final String refreshToken) {
    return KeyValueUtility.setString(_sessionRefreshTokenKey, refreshToken);
  }

  Future<void> clear() async {
    await KeyValueUtility.clear();
  }
}