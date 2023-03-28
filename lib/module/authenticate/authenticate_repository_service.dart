import 'dart:convert';

import 'package:flutter/material.dart';

import '../../dialog/alert_dialog_route.dart';
import '../../service/network_service.dart';
import 'model/authenticate_user_model.dart';

class AuthenticateRepositoryService {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getNetworkHeader;
  final Future<void> Function(BuildContext, NetworkResponse?) _handleErrorMessage;

  const AuthenticateRepositoryService(this._getHostAddress, this._getNetworkHeader, this._handleErrorMessage,);

  Future<AuthenticateUserModel?> user(final BuildContext context, {
    required final String id,
    required final String password,
  }) async {
    AlertDialogRoute.showLoading(context);

    final result = await NetworkService.get(
      hostAddress: _getHostAddress(),
      apiRoute: 'authenticate/user',
      headerMap: _getNetworkHeader(),
      bodyMap: {
        'id': id,
        'password': password,
      },
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkService.isSuccess(result)) {
      return AuthenticateUserModel.fromJson(jsonDecode(result?.body ?? '{}'));
    } else if (context.mounted) {
      await _handleErrorMessage(context, result);
    }

    return null;
  }
}
