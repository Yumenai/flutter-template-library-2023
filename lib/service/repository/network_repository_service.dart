import 'dart:convert';

import 'package:flutter/material.dart';

import '../../route/dialog/alert_dialog_route.dart';
import '../../utility/network_utility.dart';
import 'network/user_network_repository_service.dart';

class NetworkRepositoryService {
  late final user = UserNetworkRepositoryService(_getHostAddress, _getNetworkHeader, _handleErrorMessage,);

  final String Function() _getHostAddress;
  final String Function() _getAccessToken;
  final String Function() _getRefreshToken;

  NetworkRepositoryService({
    required final String Function() getHostAddress,
    required final String Function() getAccessToken,
    required final String Function() getRefreshToken,
  }) :  _getHostAddress = getHostAddress,
        _getAccessToken = getAccessToken,
        _getRefreshToken = getRefreshToken;

  Future<Map<String, String>> _getNetworkHeader({
    bool returnRefreshToken = false,
  }) async {
    return {
      'access-token': _getAccessToken(),
      if (returnRefreshToken) 'refresh-token': _getRefreshToken(),
    };
  }

  Future<void> _handleErrorMessage(final BuildContext context, final NetworkResponse? response) async {
    if (response == null) return;

    final String title;
    final String message;
    if (response.body.contains('https')) {
      title = 'API Web Error';
      message = response.body;
    } else {
      final errorMap = jsonDecode(response.body);

      title = errorMap?['title']?.toString() ?? 'Error ${response.statusCode}';
      message = errorMap?['message']?.toString() ?? 'Something unexpected happened. Please try again.';
    }

    await AlertDialogRoute.show(
      context,
      title: title,
      message: message,
    );
  }
}
