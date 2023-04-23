import 'package:flutter/material.dart';

import '../../app_master.dart';

class AppDashboardControllerRoute {

  const AppDashboardControllerRoute();

  void viewSettings(final BuildContext context) {
    AppMaster.of(context).directoryRoute?.navigator.splash();
  }
}
