import 'package:flutter/material.dart';

import '../../../data/configuration_data.dart';
import '../../../utility/dialog_utility.dart';
import 'datasource/authenticate_network_datasource_data.dart';
import 'datasource/authenticate_network_mock_datasource_data.dart';
import 'datasource/authenticate_setting_datasource_data.dart';

class AuthenticateRepositoryData {
  final _settingDatasource = const AuthenticateSettingDatasourceData();
  final _networkDatasource = const AuthenticateNetworkDatasourceData();
  final _networkMockDatasource = const AuthenticateNetworkMockDatasourceData();

  const AuthenticateRepositoryData();


  Future<String> getSessionRefreshToken() async {
    return _settingDatasource.getSessionRefreshToken();
  }

  Future<void> setSessionRefreshToken(final String? sessionRefreshToken) async {
    if (sessionRefreshToken == null) return;

    await _settingDatasource.setSessionRefreshToken(sessionRefreshToken);
  }


  Future<bool> user(final BuildContext context, {
    required final String id,
    required final String password,
    final void Function(String?)? onErrorId,
    final void Function(String?)? onErrorPassword,
  }) async {
    DialogUtility.showLoading(context);

    final model = ConfigurationData.isMockedData ? await _networkMockDatasource.user(
      context,
      id: id,
      password: password,
      onFormErrorId: onErrorId,
      onFormErrorPassword: onErrorPassword,
    ) :  await _networkDatasource.user(
      context,
      id: id,
      password: password,
      onFormErrorId: onErrorId,
      onFormErrorPassword: onErrorPassword,
    );

    if (context.mounted) Navigator.pop(context);

    if (model == null) return false;

    await _settingDatasource.setSessionRefreshToken(model.refreshToken);

    return true;
  }

  Future<void> clear() async {
    await _settingDatasource.setSessionRefreshToken('');
  }
}
