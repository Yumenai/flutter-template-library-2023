import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../service/network_service.dart';
import '../../utility/dialog_utility.dart';
import 'model/user_registration_model.dart';

class UserRepositoryService {
  final String Function() _getHostAddress;
  final Map<String, String> Function() _getNetworkHeader;
  final Future<dynamic> Function(BuildContext, NetworkResponse?, [void Function(Map)?]) _handleErrorMessage;

  const UserRepositoryService(this._getHostAddress, this._getNetworkHeader, this._handleErrorMessage,);

  Future<UserModel?> get(final BuildContext context) async {
    DialogUtility.showLoading(context);

    final result = await NetworkService.get(
      hostAddress: _getHostAddress(),
      apiRoute: 'user/get',
      headerMap: _getNetworkHeader(),
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkService.isSuccess(result)) {
      return UserModel.fromNetworkRepository(jsonDecode(result.body));
    } else if (context.mounted) {
      await _handleErrorMessage(context, result);
    }

    return null;
  }

  Future<UserRegistrationModel?> register(final BuildContext context, {
    required final String id,
    required final String name,
    required final String email,
    required final String password,
  }) async {
    DialogUtility.showLoading(context);

    final result = await NetworkService.get(
      hostAddress: _getHostAddress(),
      apiRoute: 'user/register',
      headerMap: _getNetworkHeader(),
      bodyMap: {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkService.isSuccess(result)) {
      return UserRegistrationModel.fromJson(jsonDecode(result.body));
    } else if (context.mounted) {
      await _handleErrorMessage(context, result);
    }

    return null;
  }
}