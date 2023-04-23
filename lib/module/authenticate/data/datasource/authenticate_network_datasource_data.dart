import 'package:flutter/material.dart';

import '../../../../service/network_service.dart';
import '../../model/authenticate_user_model.dart';

class AuthenticateNetworkDatasourceData {
  const AuthenticateNetworkDatasourceData();

  Future<AuthenticateUserModel?> user(final BuildContext context, {
    required final String id,
    required final String password,
    final void Function(String?)? onFormErrorId,
    final void Function(String?)? onFormErrorPassword,
  }) async {
    final response = await NetworkService.get(
      context,
      apiRoute: 'authenticate/user',
      body: {
        'id': id,
        'password': password,
      },
      errorFormHandler: (errorForm) {
        onFormErrorId?.call(errorForm['id']);
        onFormErrorPassword?.call(errorForm['password']);
      },
    );

    if (response == null) return null;

    return AuthenticateUserModel.fromJson(response.responseMap);
  }
}
