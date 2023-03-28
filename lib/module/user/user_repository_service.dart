import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../dialog/alert_dialog_route.dart';
import '../../service/network_service.dart';

class UserRepositoryService {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getNetworkHeader;
  final Future<void> Function(BuildContext, NetworkResponse?) _handleErrorMessage;

  const UserRepositoryService(this._getHostAddress, this._getNetworkHeader, this._handleErrorMessage,);

  Future<UserModel?> get(final BuildContext context) async {
    AlertDialogRoute.showLoading(context);

    final result = await NetworkService.get(
      hostAddress: _getHostAddress(),
      apiRoute: 'user/get',
      headerMap: _getNetworkHeader(),
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkService.isSuccess(result)) {
      return UserModel.fromNetworkRepository(jsonDecode(result?.body ?? '{}'));
    } else if (context.mounted) {
      await _handleErrorMessage(context, result);
    }

    return null;
  }

  Future<bool> updateProfile(final BuildContext context, {
    final String name = '',
  }) async {
    AlertDialogRoute.showLoading(context);

    final result = await NetworkService.post(
      hostAddress: _getHostAddress(),
      apiRoute: 'user/updateProfile',
      headerMap: _getNetworkHeader(),
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkService.isSuccess(result)) {
      return true;
    } else if (context.mounted) {
      await _handleErrorMessage(context, result);
    }

    return false;
  }
}