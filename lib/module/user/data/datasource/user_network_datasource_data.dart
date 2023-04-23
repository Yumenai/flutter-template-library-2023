import 'package:flutter/material.dart';

import '../../../../service/network_service.dart';

class UserNetworkDatasourceData {
  const UserNetworkDatasourceData();

  Future<bool> registration(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
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
    );

    return response?.statusCode == 200;
  }
}
