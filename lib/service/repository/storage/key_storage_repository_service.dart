import 'package:flutter/material.dart';

import '../../../data/variable/environment_variable_data.dart';
import '../../../utility/storage/key_storage_utility.dart';

const _appThemeKey = 'app-theme';
const _appThemeDarkValue = 1;
const _appThemeLightValue = 2;
const _appThemeSystemValue = 3;

const _appEnvironmentKey = 'app-environment';
const _appEnvironmentProductionValue = 1;
const _appEnvironmentUserAcceptanceTestValue = 2;
const _appEnvironmentSystemIntegrationTestValue = 3;
const _appEnvironmentDevelopmentValue = 4;

const _appLanguageKey = 'app-language';
const _refreshTokenKey = 'refresh-token';


class KeyStorageRepositoryService {
  const KeyStorageRepositoryService();

  Future<ThemeMode?> get appThemeMode async {
    final value = await KeyStorageUtility.getInt(_appThemeKey);

    if (value == _appThemeDarkValue) {
      return ThemeMode.dark;
    } else if (value == _appThemeLightValue) {
      return ThemeMode.light;
    } else if (value == _appThemeSystemValue) {
      return ThemeMode.system;
    } else {
      return null;
    }
  }

  Future<EnvironmentVariableData?> get appEnvironmentData async {
    final environmentCode = await KeyStorageUtility.getInt(_appEnvironmentKey);

    if (environmentCode == _appEnvironmentProductionValue) {
      return EnvironmentVariableData.production;
    } else if (environmentCode == _appEnvironmentUserAcceptanceTestValue) {
      return EnvironmentVariableData.userAcceptanceTest;
    } else if (environmentCode == _appEnvironmentSystemIntegrationTestValue) {
      return EnvironmentVariableData.systemIntegrationTest;
    } else if (environmentCode == _appEnvironmentDevelopmentValue) {
      return EnvironmentVariableData.development;
    }

    return null;
  }

  Future<String> get appLanguageCode async {
    return await KeyStorageUtility.getString(_appLanguageKey) ?? '';
  }

  Future<String> get refreshToken async {
    return await KeyStorageUtility.getString(_refreshTokenKey) ?? '';
  }

  Future<void> setAppThemeMode(final ThemeMode? themeMode) async {
    if (themeMode == ThemeMode.dark) {
      await KeyStorageUtility.setInt(_appThemeKey, _appThemeDarkValue);
    } else if (themeMode == ThemeMode.light) {
      await KeyStorageUtility.setInt(_appThemeKey, _appThemeLightValue);
    } else if (themeMode == ThemeMode.system) {
      await KeyStorageUtility.setInt(_appThemeKey, _appThemeSystemValue);
    }
  }

  Future<void> setEnvironmentData(final EnvironmentVariableData? data) async {
    if (data == EnvironmentVariableData.production) {
      await KeyStorageUtility.setInt(_appEnvironmentKey, _appEnvironmentProductionValue);
    } else if (data == EnvironmentVariableData.userAcceptanceTest) {
      await KeyStorageUtility.setInt(_appEnvironmentKey, _appEnvironmentUserAcceptanceTestValue);
    } else if (data == EnvironmentVariableData.systemIntegrationTest) {
      await KeyStorageUtility.setInt(_appEnvironmentKey, _appEnvironmentSystemIntegrationTestValue);
    } else if (data == EnvironmentVariableData.development) {
      await KeyStorageUtility.setInt(_appEnvironmentKey, _appEnvironmentDevelopmentValue);
    }
  }

  Future<void> setAppLanguageCode(final String? languageCode) async {
    await KeyStorageUtility.setString(_appLanguageKey, languageCode ?? '');
  }

  Future<void> setRefreshToken(final String? refreshToken) async {
    await KeyStorageUtility.setString(_refreshTokenKey, refreshToken ?? '');
  }

  Future<void> clear() async {
    await KeyStorageUtility.clear();
  }
}