import 'package:flutter/material.dart';

import '../../../../data/mock_network_data.dart';
import '../../../../provider/app_provider.dart';
import '../../../../utility/dialog_utility.dart';

class UserNetworkMockDatasourceData {
  const UserNetworkMockDatasourceData();

  Future<bool> registration(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
    required final void Function(String?)? onFormErrorId,
  }) async {
    await MockNetworkData.mockLoading();

    if (!context.mounted) return false;

    for (final user in MockNetworkData.userList) {
      if (user['authenticate_id'] == id) {
        if (user['authenticate_password'] == password) {
          await DialogUtility.showAlert(
            context,
            title: 'ID have already been registered',
            message: 'Please select another unique ID to register.',
            color: AppProvider.of(context).color.error,
            onColor: AppProvider.of(context).color.onError,
          );

          onFormErrorId?.call('ID have already been registered.');

          return false;
        }
      }
    }

    MockNetworkData.userList.add(MockNetworkData.formatUser(
      id: int.parse(MockNetworkData.userList.last['id']).toString(),
      name: name,
      authenticateId: id,
      authenticatePassword: password,
      refreshToken: DateTime.now().millisecondsSinceEpoch.toString(),
      accessToken: DateTime.now().millisecondsSinceEpoch.toString(),
      avatarImageUrl: '',
      birthdate: null,
    ));

    return true;
  }
}
