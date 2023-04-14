import 'package:flutter/material.dart';

import '../../../../directory/route_directory.dart';

class AppLandingControllerRoute {
  const AppLandingControllerRoute();

  void signIn(final BuildContext context) {
    RouteDirectory.authenticate.user();
  }

  void signUp(final BuildContext context) {
    RouteDirectory.user.registration();
  }
}
