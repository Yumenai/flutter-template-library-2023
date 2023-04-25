import 'package:flutter/material.dart';

import '../../app_module.dart';

class AppDashboardControllerRoute {

  const AppDashboardControllerRoute();

  void viewSettings(final BuildContext context) {
    AppModule.of(context).directoryRoute.settings.navigate();
  }
}
