import 'package:flutter/material.dart';

import '../../../utility/dialog_utility.dart';
import 'datasource/user_network_datasource_data.dart';
import 'datasource/user_setting_datasource_data.dart';

class UserRepositoryData {
  final _networkDatasource = const UserNetworkDatasourceData();
  final _settingDatasource = const UserSettingDatasourceData();

  const UserRepositoryData();

  Future<Locale?> getLocale() async {
    final languageCode = await _settingDatasource.getLanguageCode();

    if (languageCode.isEmpty) return null;

    return Locale(languageCode);
  }

  Future<ThemeMode?> getThemeMode() async {
    return _settingDatasource.getThemeMode();
  }

  Future<void> setLocale(final Locale? locale) async {
    if (locale == null) return;

    await _settingDatasource.setLanguageCode(locale.languageCode);
  }

  Future<void> setThemeMode(final ThemeMode? themeMode) async {
    if (themeMode == null) return;

    await _settingDatasource.setThemeMode(themeMode);
  }

  Future<bool> register(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
  }) async {
    DialogUtility.showLoading(context);

    final isSuccessful = await _networkDatasource.registration(
      context,
      id: id,
      name: name,
      email: email,
      password: password,
    );

    if (context.mounted) Navigator.pop(context);

    return isSuccessful;
  }
}
