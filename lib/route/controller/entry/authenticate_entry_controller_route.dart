import 'package:flutter/material.dart';

import '../../../service/repository_service.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/entry/authenticate_entry_screen_route.dart';
import 'splash_entry_controller_route.dart';

class AuthenticateEntryControllerRoute {
  static Widget screen() {
    return AuthenticateEntryScreenRoute(
      controller: AuthenticateEntryControllerRoute._(),
    );
  }

  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: screen(),
    );
  }

  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  AuthenticateEntryControllerRoute._();

  void signIn(final State state) async {
    await RepositoryService.storage.key.setAccessToken('accessToken');

    if (!state.mounted) return;

    SplashEntryControllerRoute.navigate(state.context);
  }
}
