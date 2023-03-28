import 'package:flutter/material.dart';

import '../../service/repository_service.dart';
import '../access_route.dart';

class AuthenticationControllerRoute {
  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  AuthenticationControllerRoute();

  void signIn(final BuildContext context) async {
    await RepositoryService.instance.setSessionRefreshToken('accessToken');

    if (context.mounted) {
      AccessRoute.splash(context);
    }
  }
}
