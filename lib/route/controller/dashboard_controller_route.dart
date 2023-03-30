import 'package:flutter/material.dart';

import '../access_route.dart';

class DashboardControllerRoute {
  const DashboardControllerRoute();

  void viewSettings(final BuildContext context) async {
    AccessRoute.user.setting(context);
  }
}
