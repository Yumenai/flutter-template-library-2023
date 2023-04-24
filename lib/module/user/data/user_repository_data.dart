import 'package:flutter/material.dart';

import '../../../data/configuration_data.dart';
import '../../../utility/dialog_utility.dart';
import 'datasource/user_network_datasource_data.dart';
import 'datasource/user_network_mock_datasource_data.dart';
import 'datasource/user_setting_datasource_data.dart';

class UserRepositoryData {
  final _networkDatasource = const UserNetworkDatasourceData();
  final _networkMockDatasource = const UserNetworkMockDatasourceData();
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
    final void Function(String?)? onFormErrorId,
  }) async {
    DialogUtility.showLoading(context);

    final isSuccessful = ConfigurationData.isMockedData ? await _networkMockDatasource.registration(
      context,
      id: id,
      name: name,
      email: email,
      password: password,
      onFormErrorId: onFormErrorId,
    ) : await _networkDatasource.registration(
      context,
      id: id,
      name: name,
      email: email,
      password: password,
      onFormErrorId: onFormErrorId,
    );

    if (context.mounted) Navigator.pop(context);

    return isSuccessful;
  }

  Future<bool> updatePassword(final BuildContext context, {
    required final String currentPassword,
    required final String replacePassword,
    final void Function(String?)? onFormErrorCurrentPassword,
    final void Function(String?)? onFormErrorReplacePassword,
  }) async {
    DialogUtility.showLoading(context);

    final isSuccessful = ConfigurationData.isMockedData ? await _networkMockDatasource.updatePassword(
      context,
      currentPassword: currentPassword,
      replacePassword: replacePassword,
      onFormErrorCurrentPassword: onFormErrorCurrentPassword,
      onFormErrorReplacePassword: onFormErrorReplacePassword,
    ) : await _networkDatasource.updatePassword(
      context,
      currentPassword: currentPassword,
      replacePassword: replacePassword,
      onFormErrorCurrentPassword: onFormErrorCurrentPassword,
      onFormErrorReplacePassword: onFormErrorReplacePassword,
    );

    if (context.mounted) Navigator.pop(context);

    return isSuccessful;
  }

  Future<bool> deleteAccount(final BuildContext context, {
    required final String password,
    final void Function(String?)? onFormErrorPassword,
  }) async {
    DialogUtility.showLoading(context);

    final isSuccessful = ConfigurationData.isMockedData ? await _networkMockDatasource.deleteAccount(
      context,
      password: password,
      onFormErrorPassword: onFormErrorPassword,
    ) : await _networkDatasource.deleteAccount(
      context,
      password: password,
      onFormErrorPassword: onFormErrorPassword,
    );

    if (context.mounted) Navigator.pop(context);

    return isSuccessful;
  }

  Future<void> clear() async {
    await _settingDatasource.clear();
  }
}
