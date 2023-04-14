import 'package:flutter/material.dart';

import '../../directory/dialog_directory.dart';
import '../../utility/network_utility.dart';
import 'datasource/authenticate_network_datasource.dart';
import 'model/authenticate_user_model.dart';

class AuthenticateRepository {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getHeaderConfiguration;
  final Future<void> Function(BuildContext, int, String, [void Function(Map)?]) _handleErrorMessage;

  late final _networkDatasource = AuthenticateNetworkDatasource(_getHostAddress, _getHeaderConfiguration);

  AuthenticateRepository(this._getHostAddress, this._getHeaderConfiguration, this._handleErrorMessage);

  Future<AuthenticateUserModel?> user(final BuildContext context, {
    required final String id,
    required final String password,
    final void Function(String)? onErrorId,
    final void Function(String)? onErrorPassword,
  }) async {
    DialogDirectory.showLoading(context);

    final networkModel = await _networkDatasource.user(
      context,
      id: id,
      password: password,
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkUtility.isSuccessCode(networkModel.statusCode)) {
      return AuthenticateUserModel.fromJson(networkModel.responseMap);
    } else if (context.mounted) {
      await _handleErrorMessage(context, networkModel.statusCode, networkModel.response, (errorForm) {
        onErrorId?.call(errorForm['id']?.toString() ?? '');
        onErrorPassword?.call(errorForm['password']?.toString() ?? '');
      });
    }

    return null;
  }
}
