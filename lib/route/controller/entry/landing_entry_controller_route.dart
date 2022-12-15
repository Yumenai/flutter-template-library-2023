import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import '../../screen/entry/landing_entry_screen_route.dart';
import 'authenticate_entry_controller_route.dart';
import 'register_entry_controller_route.dart';

class LandingEntryControllerRoute {
  static Widget screen() {
    return const LandingEntryScreenRoute(
      controller: LandingEntryControllerRoute._(),
    );
  }

  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: screen(),
    );
  }

  const LandingEntryControllerRoute._();

  void signIn(final BuildContext context) {
    AuthenticateEntryControllerRoute.navigate(context);
  }

  void signUp(final BuildContext context) {
    RegisterEntryControllerRoute.navigate(context);
  }
}
