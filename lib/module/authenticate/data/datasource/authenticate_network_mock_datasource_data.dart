import 'package:flutter/material.dart';

import '../../../../data/mock_network_data.dart';
import '../../../../provider/app_provider.dart';
import '../../../../utility/dialog_utility.dart';
import '../../model/authenticate_user_model.dart';

class AuthenticateNetworkMockDatasourceData {
  const AuthenticateNetworkMockDatasourceData();

  Future<AuthenticateUserModel?> user(final BuildContext context, {
    required final String id,
    required final String password,
    final void Function(String?)? onFormErrorId,
    final void Function(String?)? onFormErrorPassword,
  }) async {
    await MockNetworkData.mockLoading();

    for (final user in MockNetworkData.userList) {
      if (user['authenticate_id'] == id) {
        if (user['authenticate_password'] == password) {
          return AuthenticateUserModel(
            refreshToken: user['refresh_token']?.toString() ?? '',
          );
        }
      }
    }

    if (!context.mounted) return null;

    onFormErrorId?.call('Invalid ID or Password');
    onFormErrorPassword?.call('Invalid ID or Password');

    await DialogUtility.showAlert(
      context,
      title: 'Invalid ID or Password',
      message: 'Please input the correct ID and Password',
      color: AppProvider.of(context).color.error,
      onColor: AppProvider.of(context).color.onError,
    );

    return null;
  }
}
