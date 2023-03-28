import 'package:flutter/material.dart';

import '../../../../service/repository_service.dart';
import '../../../../route/access_route.dart';

class AuthenticationUserControllerRoute {
  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  AuthenticationUserControllerRoute();

  void signIn(final BuildContext context) async {
    // final result = await RepositoryService.instance.authenticate.user(
    //   context,
    //   id: idInputController.text.trim(),
    //   password: passwordInputController.text.trim(),
    // );
    //
    // if (result == null) return;
    //
    // if (!context.mounted) return;
    //
    // await RepositoryService.instance.setSessionRefreshToken(result.refreshToken);

    await RepositoryService.instance.setSessionRefreshToken('sample-refresh-token');

    if (!context.mounted) return;

    AccessRoute.splash(context);
  }
}

