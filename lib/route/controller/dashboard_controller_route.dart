import 'package:flutter/material.dart';

import '../../service/repository_service.dart';
import '../../utility/navigator_utility.dart';
import '../screen/dashboard_screen_route.dart';
import 'entry/splash_entry_controller_route.dart';

class DashboardControllerRoute {
  static Widget screen() {
    return const DashboardScreenRoute(
      controller: DashboardControllerRoute._(),
    );
  }

  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: screen(),
    );
  }

  const DashboardControllerRoute._();

  void signOut(final State state) async {
    await RepositoryService.storage.key.clear();

    if (!state.mounted) return;

    SplashEntryControllerRoute.navigate(state.context);
  }
}