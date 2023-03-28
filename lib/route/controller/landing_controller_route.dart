import 'package:flutter/material.dart';

import '../access_route.dart';

class LandingControllerRoute {
  const LandingControllerRoute();

  void signIn(final BuildContext context) {
    AccessRoute.authenticate.user(context);
  }

  void signUp(final BuildContext context) {
    AccessRoute.user.registration(context);
  }
}
