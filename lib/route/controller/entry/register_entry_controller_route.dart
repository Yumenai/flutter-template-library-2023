import 'package:flutter/material.dart';

import '../../../service/repository_service.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/entry/register_entry_screen_route.dart';
import 'splash_entry_controller_route.dart';

class RegisterEntryControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: RegisterEntryScreenRoute(
        controller: RegisterEntryControllerRoute._(),
      ),
    );
  }

  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  RegisterEntryControllerRoute._();

  void signUp(final State state) async {
    await RepositoryService.storage.key.setAccessToken('accessToken');

    if (!state.mounted) return;

    SplashEntryControllerRoute.navigate(state.context);
  }
}
