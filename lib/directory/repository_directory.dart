import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/configuration_data.dart';
import '../module/app/app_repository.dart';
import '../data/variable/environment_variable_data.dart';
import '../module/authenticate/authenticate_repository.dart';
import '../module/user/user_repository.dart';
import 'dialog_directory.dart';
import '../provider/app_provider.dart';

class RepositoryDirectory {
  static RepositoryDirectory? _instance;

  static AppRepository? get app => _instance?._app;

  static AuthenticateRepository? get authenticate => _instance?._authenticate;

  static UserRepository? get user => _instance?._user;

  static Future<void> initialise() async {
    _instance = RepositoryDirectory._(
      await AppRepository.initialise(),
      AuthenticateRepository(_getHostAddress, _getHeaderConfiguration, _handleErrorMessage),
      UserRepository(_getHostAddress, _getHeaderConfiguration, _handleErrorMessage),
    );
  }

  static Future<void> clear() async {
    await _instance?._app.clear();
  }

  static String _getHostAddress() {
    if (ConfigurationData.isDevelopmentMode) {
      switch(_instance?._app.environmentVariable) {
        case EnvironmentVariableData.production:
          return ConfigurationData.hostAddressProduction;
        case EnvironmentVariableData.userAcceptanceTest:
          return ConfigurationData.hostAddressUserAcceptanceTest;
        case EnvironmentVariableData.systemIntegrationTest:
          return ConfigurationData.hostAddressSystemIntegrationTest;
        case EnvironmentVariableData.development:
        default:
          return ConfigurationData.hostAddressDevelopment;
      }
    } else {
      return ConfigurationData.hostAddressProduction;
    }
  }

  static Map<String, String> _getHeaderConfiguration() {
    return {
      'access-token': _instance?._app.sessionAccessToken ?? '',
    };
  }

  static Future<void> _handleErrorMessage(final BuildContext context, final int statusCode, final String response, [
    final void Function(Map)? formResponse,
  ]) async {

    final String title;
    final String message;
    if (response.contains('https')) {
      title = 'API Web Error';
      message = response;
    } else {
      final errorMap = jsonDecode(response)?['error'];

      title = errorMap?['title']?.toString() ?? 'Error $statusCode';
      message = errorMap?['message']?.toString() ?? 'Something unexpected happened. Please try again.';

      final formErrorMap = errorMap?['form'];

      if (formErrorMap != null) {
        formResponse?.call(formErrorMap);
      }
    }

    await DialogDirectory.showAlert(
      context,
      title: title,
      message: message,
      color: AppProvider.of(context).color.error,
      onColor: AppProvider.of(context).color.onError,
    );
  }

  final AppRepository _app;
  final AuthenticateRepository _authenticate;
  final UserRepository _user;


  const RepositoryDirectory._(this._app, this._authenticate, this._user);
}