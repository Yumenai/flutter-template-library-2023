import 'package:flutter/material.dart';

import '../../../model/network_model.dart';
import '../../../utility/network_utility.dart';

class AuthenticateNetworkDatasource {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getHeaderConfiguration;

  const AuthenticateNetworkDatasource(this._getHostAddress, this._getHeaderConfiguration);

  Future<NetworkModel> user(final BuildContext context, {
    required final String id,
    required final String password,
  }) async {

    final response = await NetworkUtility.get(
      hostAddress: _getHostAddress(),
      apiRoute: 'authenticate/user',
      headerMap: _getHeaderConfiguration(),
      bodyMap: {
        'id': id,
        'password': password,
      },
    );

    return NetworkModel(
      statusCode: response.statusCode,
      response: response.body,
    );
  }
}
