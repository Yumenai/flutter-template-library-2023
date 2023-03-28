import 'package:flutter/material.dart';

import '../../../../service/repository_service.dart';
import '../../../../route/access_route.dart';

class UserRegistrationControllerRoute {
  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  UserRegistrationControllerRoute();

  void signUp(final BuildContext context) async {
    // final result = await RepositoryService.instance.user.register(
    //   context,
    //   id: idInputController.text.trim(),
    //   name: nameInputController.text.trim(),
    //   email: emailInputController.text.trim(),
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
