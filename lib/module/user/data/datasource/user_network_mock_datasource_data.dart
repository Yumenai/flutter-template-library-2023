import 'package:flutter/material.dart';

import '../../../../data/mock_network_data.dart';
import '../../../../provider/app_provider.dart';
import '../../../../utility/dialog_utility.dart';
import '../../model/user_profile_model.dart';
import '../../model/user_setup_model.dart';

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
      email: email,
      authenticateId: id,
      authenticatePassword: password,
      refreshToken: DateTime.now().millisecondsSinceEpoch.toString(),
      accessToken: DateTime.now().millisecondsSinceEpoch.toString(),
      avatarImageUrl: '',
      birthdate: null,
    ));

    return true;
  }

  Future<UserSetupModel?> setup(final BuildContext context, {
    required final String sessionRefreshToken,
  }) async {
    await MockNetworkData.mockLoading();

    if (!context.mounted) return null;

    for (int i = 0; i < MockNetworkData.userList.length; i++) {
      final data = MockNetworkData.userList[i];
      if (data['session_refresh_token'] == sessionRefreshToken) {
        return UserSetupModel.fromJson({
          'session_access_token': data['session_access_token'],
          'profile': data,
        });
      }
    }

    if (!context.mounted) return null;

    return null;
  }

  Future<UserProfileModel?> getProfile(final BuildContext context) async {
    await MockNetworkData.mockLoading();

    if (!context.mounted) return null;

    for (int i = 0; i < MockNetworkData.userList.length; i++) {
      final data = MockNetworkData.userList[i];
      if (data['session_access_token'] == AppProvider.of(context).accessToken) {
        return UserProfileModel.fromJson(data);
      }
    }

    if (!context.mounted) return null;

    return null;
  }

  Future<UserProfileModel?> updateProfile(final BuildContext context, {
    required final String name,
    required final String email,
    required final DateTime? birthdate,
    required final void Function(String?)? onFormErrorName,
    required final void Function(String?)? onFormErrorEmail,
  }) async {
    await MockNetworkData.mockLoading();

    if (!context.mounted) return null;

    for (int i = 0; i < MockNetworkData.userList.length; i++) {
      final data = MockNetworkData.userList[i];

      if (data['session_access_token'] == AppProvider.of(context).accessToken) {
        data['name'] = name;
        data['email'] = email;
        data['birthdate'] = birthdate?.toIso8601String() ?? '';

        return UserProfileModel.fromJson(data);
      }
    }

    return null;
  }

  Future<bool> updatePassword(final BuildContext context, {
    required final String currentPassword,
    required final String replacePassword,
    required final void Function(String?)? onFormErrorCurrentPassword,
    required final void Function(String?)? onFormErrorReplacePassword,
  }) async {
    await MockNetworkData.mockLoading();

    if (!context.mounted) return false;

    if (currentPassword == replacePassword) {
      await DialogUtility.showAlert(
        context,
        title: 'Invalid New Password',
        message: 'New password cannot be the same as current password.',
        color: AppProvider.of(context).color.error,
        onColor: AppProvider.of(context).color.onError,
      );

      onFormErrorReplacePassword?.call('New password cannot be the same as current password');
      return false;
    }

    for (int i = 0; i < MockNetworkData.userList.length; i++) {
      final data = MockNetworkData.userList[i];

      if (data['session_access_token'] == AppProvider.of(context).accessToken) {
        if (data['authenticate_password'] == currentPassword) {
          MockNetworkData.userList[i]['authenticate_password'] = replacePassword;

          return true;
        }
      }
    }

    await DialogUtility.showAlert(
      context,
      title: 'Invalid Password',
      message: 'Your current password does not matched your registered password.',
      color: AppProvider.of(context).color.error,
      onColor: AppProvider.of(context).color.onError,
    );

    onFormErrorCurrentPassword?.call('Invalid Current Password');

    return false;
  }

  Future<bool> deleteAccount(final BuildContext context, {
    required final String password,
    required final void Function(String?)? onFormErrorPassword,
  }) async {
    await MockNetworkData.mockLoading();

    for (int i = 0; i < MockNetworkData.userList.length; i++) {
      final data = MockNetworkData.userList[i];
      if (data['authenticate_password'] == password) {
        MockNetworkData.userList.removeAt(i);

        return true;
      }
    }

    if (!context.mounted) return false;

    await DialogUtility.showAlert(
      context,
      title: 'Invalid Password',
      message: 'Your current password does not matched your registered password.',
      color: AppProvider.of(context).color.error,
      onColor: AppProvider.of(context).color.onError,
    );

    onFormErrorPassword?.call('Invalid Password');

    return false;
  }
}
