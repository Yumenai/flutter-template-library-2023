import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';
import '../../../../utility/interface_utility.dart';

class UserRegistrationControllerRoute {
  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  UserRegistrationControllerRoute();

  void signUp(final BuildContext context) async {
    await InterfaceUtility.clearFocus(context);

    RepositoryDirectory.app?.sessionRefreshToken = 'sample-refresh-token';

    if (!context.mounted) return;

    RouteDirectory.app.navigator.splash();
  }
}
