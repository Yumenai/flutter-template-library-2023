import 'package:flutter/material.dart';

import '../../utility/network_utility.dart';
import '../../directory/dialog_directory.dart';
import 'datasource/user_network_datasource.dart';
import 'model/user_registration_model.dart';

class UserRepository {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getHeaderConfiguration;
  final Future<void> Function(BuildContext, int, String) _handleErrorMessage;

  late final _networkDatasource = UserNetworkDatasource(_getHostAddress, _getHeaderConfiguration);

  UserRepository(this._getHostAddress, this._getHeaderConfiguration, this._handleErrorMessage);

  Future<UserRegistrationModel?> register(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
  }) async {
    DialogDirectory.showLoading(context);

    final networkModel = await _networkDatasource.register(
      context,
      id: id,
      name: name,
      email: email,
      password: password,
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkUtility.isSuccessCode(networkModel.statusCode)) {
      return UserRegistrationModel.fromJson(networkModel.responseMap);
    } else if (context.mounted) {
      await _handleErrorMessage(context, networkModel.statusCode, networkModel.response);
    }

    return null;
  }
}