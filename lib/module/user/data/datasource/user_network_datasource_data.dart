import 'package:flutter/material.dart';

import '../../../../service/network_service.dart';
import '../../../../utility/format_utility.dart';
import '../../model/user_profile_model.dart';
import '../../model/user_setup_model.dart';

class UserNetworkDatasourceData {
  const UserNetworkDatasourceData();

  Future<bool> registration(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
    required final void Function(String?)? onFormErrorId,
    required final void Function(String?)? onFormErrorName,
    required final void Function(String?)? onFormErrorEmail,
    required final void Function(String?)? onFormErrorPassword,
    required final void Function(String?)? onFormErrorConfirmPassword,
  }) async {
    final response = await NetworkService.get(
      context,
      apiRoute: 'user/register',
      body: {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      },
      errorFormHandler: (errorForm) {
        onFormErrorId?.call(errorForm['id']);
        onFormErrorName?.call(errorForm['name']);
        onFormErrorEmail?.call(errorForm['email']);
        onFormErrorPassword?.call(errorForm['password']);
        onFormErrorConfirmPassword?.call(errorForm['confirm_password']);
      },
    );

    return response?.statusCode == 200;
  }

  Future<UserSetupModel?> setup(final BuildContext context, {
    required final String sessionRefreshToken,
  }) async {
    final response = await NetworkService.get(
      context,
      apiRoute: 'user/setup',
      body: {
        'session_refresh_token': sessionRefreshToken,
      },
    );

    if (response?.statusCode == 200) {
      return UserSetupModel.fromJson(response?.responseMap);
    }

    return null;
  }

  Future<UserProfileModel?> getProfile(final BuildContext context) async {
    final response = await NetworkService.get(
      context,
      apiRoute: 'user/getProfile',
    );

    if (response?.statusCode == 200) {
      return UserProfileModel.fromJson(response?.responseMap);
    }

    return null;
  }

  Future<UserProfileModel?> updateProfile(final BuildContext context, {
    required final String name,
    required final String email,
    required final DateTime? birthdate,
    required final void Function(String?)? onFormErrorName,
    required final void Function(String?)? onFormErrorEmail,
  }) async {
    final response = await NetworkService.post(
      context,
      apiRoute: 'user/updateProfile',
      body: {
        'name': name,
        'email': email,
        'birthdate': FormatUtility.date(birthdate),
      },
      errorFormHandler: (errorForm) {
        onFormErrorName?.call(errorForm['name']);
        onFormErrorEmail?.call(errorForm['email']);
      },
    );

    if (response?.statusCode == 200) {
      return UserProfileModel.fromJson(response?.responseMap);
    }

    return null;
  }

  Future<bool> updatePassword(final BuildContext context, {
    required final String currentPassword,
    required final String replacePassword,
    required final void Function(String?)? onFormErrorCurrentPassword,
    required final void Function(String?)? onFormErrorReplacePassword,
  }) async {
    final response = await NetworkService.post(
      context,
      apiRoute: 'user/updatePassword',
      body: {
        'current_password': currentPassword,
        'replace_password': replacePassword,
      },
      errorFormHandler: (errorForm) {
        onFormErrorCurrentPassword?.call(errorForm['current_password']);
        onFormErrorReplacePassword?.call(errorForm['replace_password']);
      },
    );

    return response?.statusCode == 200;
  }

  Future<bool> deleteAccount(final BuildContext context, {
    required final String password,
    required final void Function(String?)? onFormErrorPassword,
  }) async {
    final response = await NetworkService.post(
      context,
      apiRoute: 'user/deleteAccount',
      body: {
        'password': password,
      },
      errorFormHandler: (errorForm) {
        onFormErrorPassword?.call(errorForm['password']);
      },
    );

    return response?.statusCode == 200;
  }
}
