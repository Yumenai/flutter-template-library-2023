import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';
import '../../../../utility/interface_utility.dart';

class AuthenticationUserControllerRoute {
  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  AuthenticationUserControllerRoute();

  void signIn(final BuildContext context) async {
    await InterfaceUtility.clearFocus(context);

    RepositoryDirectory.app?.sessionRefreshToken = 'sample-refresh-token';

    if (!context.mounted) return;

    RouteDirectory.app.navigator.splash();
  }
}

