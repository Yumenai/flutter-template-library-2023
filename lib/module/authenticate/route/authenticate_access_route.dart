import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import 'controller/authenticate_user_controller_route.dart';
import 'screen/authenticate_user_screen_route.dart';

class AuthenticateAccessRoute {
  const AuthenticateAccessRoute();

  void user(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: AuthenticateUserScreenRoute(
        controller: AuthenticationUserControllerRoute(),
      ),
    );
  }
}
