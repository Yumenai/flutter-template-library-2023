import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';

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

    RepositoryDirectory.app?.sessionRefreshToken = 'sample-refresh-token';

    if (!context.mounted) return;

    RouteDirectory.app.splash();
  }
}

