import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/configuration_data.dart';
import '../data/environment_data.dart';
import '../module/authenticate/authenticate_repository_service.dart';
import '../module/user/user_repository_service.dart';
import '../utility/dialog_utility.dart';
import 'storage/key_storage_service.dart';
import 'network_service.dart';

const _themeKey = 'app-theme';
const _themeDarkValue = 1;
const _themeLightValue = 2;
const _themeSystemValue = 3;

const _languageKey = 'app-language';

const _environmentKey = 'app-environment';
const _environmentProductionValue = 1;
const _environmentUserAcceptanceTestValue = 2;
const _environmentSystemIntegrationTestValue = 3;
const _environmentDevelopmentValue = 4;

const _sessionAccessTokenKey = 'access-token';
const _sessionRefreshTokenKey = 'refresh-token';

class RepositoryService {
  static final instance = RepositoryService._();

  late final authenticate = AuthenticateRepositoryService(_getHostAddress, _getNetworkHeader, _handleErrorMessage);
  late final user = UserRepositoryService(_getHostAddress, _getNetworkHeader, _handleErrorMessage);

  RepositoryService._();

  factory RepositoryService() {
    return instance;
  }

  ThemeMode get themeMode {
    final value = KeyStorageService.getInt(_themeKey);

    if (value == _themeDarkValue) {
      return ThemeMode.dark;
    } else if (value == _themeLightValue) {
      return ThemeMode.light;
    } else if (value == _themeSystemValue) {
      return ThemeMode.system;
    } else {
      return ConfigurationData.defaultThemeMode;
    }
  }

  String get languageCode {
    return KeyStorageService.getString(_languageKey) ?? '';
  }

  EnvironmentData get environmentData {
    final environmentCode = KeyStorageService.getInt(_environmentKey);

    if (environmentCode == _environmentProductionValue) {
      return EnvironmentData.production;
    } else if (environmentCode == _environmentUserAcceptanceTestValue) {
      return EnvironmentData.userAcceptanceTest;
    } else if (environmentCode == _environmentSystemIntegrationTestValue) {
      return EnvironmentData.systemIntegrationTest;
    } else if (environmentCode == _environmentDevelopmentValue) {
      return EnvironmentData.development;
    } else {
      return ConfigurationData.defaultEnvironment;
    }
  }

  String get sessionAccessToken {
    return KeyStorageService.getString(_sessionAccessTokenKey) ?? '';
  }

  String get sessionRefreshToken {
    return KeyStorageService.getString(_sessionRefreshTokenKey) ?? '';
  }

  Future<void> setThemeMode(final ThemeMode? themeMode) async {
    if (themeMode == ThemeMode.dark) {
      await KeyStorageService.setInt(_themeKey, _themeDarkValue);
    } else if (themeMode == ThemeMode.light) {
      await KeyStorageService.setInt(_themeKey, _themeLightValue);
    } else if (themeMode == ThemeMode.system) {
      await KeyStorageService.setInt(_themeKey, _themeSystemValue);
    }
  }

  Future<void> setLanguageCode(final String? languageCode) async {
    await KeyStorageService.setString(_languageKey, languageCode ?? '');
  }

  Future<void> setEnvironmentData(final EnvironmentData? data) async {
    if (data == EnvironmentData.production) {
      await KeyStorageService.setInt(_environmentKey, _environmentProductionValue);
    } else if (data == EnvironmentData.userAcceptanceTest) {
      await KeyStorageService.setInt(_environmentKey, _environmentUserAcceptanceTestValue);
    } else if (data == EnvironmentData.systemIntegrationTest) {
      await KeyStorageService.setInt(_environmentKey, _environmentSystemIntegrationTestValue);
    } else if (data == EnvironmentData.development) {
      await KeyStorageService.setInt(_environmentKey, _environmentDevelopmentValue);
    }
  }

  Future<void> setSessionAccessToken(final String? refreshToken) async {
    await KeyStorageService.setString(_sessionAccessTokenKey, refreshToken ?? '');
  }

  Future<void> setSessionRefreshToken(final String? refreshToken) async {
    await KeyStorageService.setString(_sessionRefreshTokenKey, refreshToken ?? '');
  }

  Future<void> clear() async {
    await KeyStorageService.clear();
  }








  String _getHostAddress() {
    if (ConfigurationData.isDevelopmentMode) {
      switch(environmentData) {
        case EnvironmentData.production:
          return ConfigurationData.hostAddressProduction;
        case EnvironmentData.userAcceptanceTest:
          return ConfigurationData.hostAddressUserAcceptanceTest;
        case EnvironmentData.systemIntegrationTest:
          return ConfigurationData.hostAddressSystemIntegrationTest;
        case EnvironmentData.development:
        default:
          return ConfigurationData.hostAddressDevelopment;
      }
    } else {
      return ConfigurationData.hostAddressProduction;
    }
  }

  Map<String, String> _getNetworkHeader() {
    return {
      'access-token': sessionAccessToken,
    };
  }

  Future<void> _handleErrorMessage(final BuildContext context, final NetworkResponse? response) async {
    if (response == null) return;

    final String title;
    final String message;
    if (response.body.contains('https')) {
      title = 'API Web Error';
      message = response.body;
    } else {
      final errorMap = jsonDecode(response.body);

      title = errorMap?['title']?.toString() ?? 'Error ${response.statusCode}';
      message = errorMap?['message']?.toString() ?? 'Something unexpected happened. Please try again.';
    }

    await DialogUtility.showAlert(
      context,
      title: title,
      message: message,
    );
  }
}
