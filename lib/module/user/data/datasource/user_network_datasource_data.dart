import 'package:flutter/material.dart';

import '../../../../service/network_service.dart';

class UserNetworkDatasourceData {
  const UserNetworkDatasourceData();

  Future<bool> registration(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
    required final void Function(String?)? onFormErrorId,
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
      },
    );

    return response?.statusCode == 200;
  }
}
