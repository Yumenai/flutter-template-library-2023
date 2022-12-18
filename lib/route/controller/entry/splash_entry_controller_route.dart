import 'package:flutter/material.dart';

import '../../../service/repository_service.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/entry/splash_entry_screen_route.dart';
import '../dashboard_controller_route.dart';
import 'landing_entry_controller_route.dart';

class SplashEntryControllerRoute {
  static Widget screen() {
    return const SplashEntryScreenRoute(
      controller: SplashEntryControllerRoute._(),
    );
  }

  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: screen(),
    );
  }

  const SplashEntryControllerRoute._();

  void initialise(final State state) async {
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    if (!state.mounted) return;

    final accessToken = await RepositoryService.storage.key.accessToken;

    if (!state.mounted) return;

    if (accessToken.isEmpty) {
      LandingEntryControllerRoute.navigate(state.context);
    } else {
      DashboardControllerRoute.navigate(state.context);
    }
  }
}
