import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../controller/app_controller.dart';
import '../../../model/user_model.dart';
import '../../../route/dialog/alert_dialog_route.dart';
import '../../../utility/network_utility.dart';

class UserNetworkRepositoryService {
  final Future<Map<String, String>> Function({bool returnRefreshToken}) getNetworkHeader;
  final Future<void> Function(BuildContext, NetworkResponse?) handleErrorMessage;

  const UserNetworkRepositoryService({
    required this.getNetworkHeader,
    required this.handleErrorMessage,
  });

  Future<UserModel?> get(final BuildContext context) async {
    AlertDialogRoute.showLoading(context);

    final result = await NetworkUtility.get(
      hostAddress: AppController.of(context).hostAddress,
      apiRoute: 'user/get',
      headerMap: await getNetworkHeader(),
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkUtility.isSuccess(result)) {
      return UserModel.fromNetworkRepository(jsonDecode(result?.body ?? '{}'));
    } else if (context.mounted) {
      await handleErrorMessage(context, result);
    }

    return null;
  }

  Future<bool> updateProfile(final BuildContext context, {
    final String name = '',
  }) async {
    AlertDialogRoute.showLoading(context);

    final result = await NetworkUtility.post(
      hostAddress: AppController.of(context).hostAddress,
      apiRoute: 'user/updateProfile',
      headerMap: await getNetworkHeader(),
    );

    if (context.mounted) Navigator.pop(context);

    if (NetworkUtility.isSuccess(result)) {
      return true;
    } else if (context.mounted) {
      await handleErrorMessage(context, result);
    }

    return false;
  }
}