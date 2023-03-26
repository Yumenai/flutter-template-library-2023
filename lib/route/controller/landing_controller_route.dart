import 'package:flutter/material.dart';

import '../access_route.dart';

class LandingControllerRoute {
  const LandingControllerRoute();

  void signIn(final BuildContext context) {
    AccessRoute.authenticate(context);
  }

  void signUp(final BuildContext context) {
    AccessRoute.register(context);
  }
}
