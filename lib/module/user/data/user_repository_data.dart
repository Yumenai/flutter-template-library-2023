import 'package:flutter/material.dart';

import '../../../data/configuration_data.dart';
import '../../../utility/dialog_utility.dart';
import '../model/user_profile_model.dart';
import 'datasource/user_memory_datasource_data.dart';
import 'datasource/user_network_datasource_data.dart';
import 'datasource/user_network_mock_datasource_data.dart';
import 'datasource/user_setting_datasource_data.dart';

class UserRepositoryData {
  final _memoryDatasource = UserMemoryDatasourceData();
  final _networkDatasource = const UserNetworkDatasourceData();
  final _networkMockDatasource = const UserNetworkMockDatasourceData();
  final _settingDatasource = const UserSettingDatasourceData();

  UserRepositoryData();

  Locale? get locale => _memoryDatasource.locale;
  set locale(final Locale? locale) {
    if (locale == null) return;

    _memoryDatasource.locale = locale;
    _settingDatasource.setLanguageCode(locale.languageCode);
  }

  ThemeMode? get themeMode => _memoryDatasource.themeMode;
  set themeMode(final ThemeMode? themeMode) {
    if (themeMode == null) return;

    _memoryDatasource.themeMode = themeMode;
    _settingDatasource.setThemeMode(themeMode);
  }

  UserProfileModel? get profileModel => _memoryDatasource.profileModel;

  String get sessionAccessToken => _memoryDatasource.sessionAccessToken;

  Future<void> initialise() async {
    final languageCode = await _settingDatasource.getLanguageCode();
    if (languageCode.isNotEmpty) {
      locale = Locale(languageCode);
    }

    themeMode = await _settingDatasource.getThemeMode();
  }

  Future<bool> register(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
    final void Function(String?)? onFormErrorId,
    final void Function(String?)? onFormErrorName,
    final void Function(String?)? onFormErrorEmail,
    final void Function(String?)? onFormErrorPassword,
    final void Function(String?)? onFormErrorConfirmPassword,
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
      onFormErrorName: onFormErrorName,
      onFormErrorEmail: onFormErrorEmail,
      onFormErrorPassword: onFormErrorPassword,
      onFormErrorConfirmPassword: onFormErrorConfirmPassword,
    );

    if (context.mounted) Navigator.pop(context);

    return isSuccessful;
  }

  Future<void> setup(final BuildContext context, {
    required final String sessionRefreshToken,
  }) async {
    final model = ConfigurationData.isMockedData ? await _networkMockDatasource.setup(
      context,
      sessionRefreshToken: sessionRefreshToken,
    ) : await _networkDatasource.setup(
      context,
      sessionRefreshToken: sessionRefreshToken,
    );

    _memoryDatasource.profileModel = model?.profileModel;
    _memoryDatasource.sessionAccessToken = model?.sessionAccessToken ?? '';
  }

  Future<UserProfileModel?> getProfile(final BuildContext context, [
    final bool enableLoadingDialog = true,
  ]) async {
    if (enableLoadingDialog) DialogUtility.showLoading(context);

    final model = ConfigurationData.isMockedData ? await _networkMockDatasource.getProfile(context) : await _networkDatasource.getProfile(context);

    if (enableLoadingDialog) if (context.mounted) Navigator.pop(context);

    if (model == null) return null;

    return _memoryDatasource.profileModel = model;
  }

  Future<UserProfileModel?> updateProfile(final BuildContext context, {
    required final String name,
    required final String email,
    required final DateTime? birthdate,
    final void Function(String?)? onFormErrorName,
    final void Function(String?)? onFormErrorEmail,
  }) async {
    DialogUtility.showLoading(context);

    final model = ConfigurationData.isMockedData ? await _networkMockDatasource.updateProfile(
      context,
      name: name,
      email: email,
      birthdate: birthdate,
      onFormErrorName: onFormErrorName,
      onFormErrorEmail: onFormErrorEmail,
    ) : await _networkDatasource.updateProfile(
      context,
      name: name,
      email: email,
      birthdate: birthdate,
      onFormErrorName: onFormErrorName,
      onFormErrorEmail: onFormErrorEmail,
    );

    if (context.mounted) Navigator.pop(context);

    if (model == null) return null;

    return _memoryDatasource.profileModel = model;
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
