import 'package:flutter/material.dart';

import '../../service/repository_service.dart';
import '../access_route.dart';

class RegisterControllerRoute {
  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  RegisterControllerRoute();

  void signUp(final BuildContext context) async {
    await RepositoryService.key.setSessionRefreshToken('accessToken');

    if (!context.mounted) return;

    AccessRoute.splash(context);
  }
}
