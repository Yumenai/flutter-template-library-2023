import 'package:flutter/material.dart';

import '../../../model/network_model.dart';
import '../../../utility/network_utility.dart';

class UserNetworkDatasource {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getHeaderConfiguration;

  const UserNetworkDatasource(this._getHostAddress, this._getHeaderConfiguration);

  Future<NetworkModel> register(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
  }) async {
    final response = await NetworkUtility.get(
      hostAddress: _getHostAddress(),
      apiRoute: 'user/register',
      headerMap: _getHeaderConfiguration(),
      bodyMap: {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return NetworkModel(
      statusCode: response.statusCode,
      response: response.body,
    );
  }
}
