import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import '../../screen/entry/register_entry_screen_route.dart';

class RegisterEntryControllerRoute {
  static Widget screen() {
    return RegisterEntryScreenRoute(
      controller: RegisterEntryControllerRoute._(),
    );
  }

  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: screen(),
    );
  }

  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  RegisterEntryControllerRoute._();

  void signUp(final BuildContext context) {

  }
}
