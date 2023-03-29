import 'package:flutter/material.dart';

import '../module/authenticate/route/authenticate_access_route.dart';
import '../module/user/route/user_access_route.dart';
import '../utility/navigator_utility.dart';
import 'controller/dashboard_controller_route.dart';
import 'controller/landing_controller_route.dart';
import 'controller/scanner_controller_route.dart';
import 'controller/splash_controller_route.dart';
import 'screen/dashboard_screen_route.dart';
import 'screen/landing_screen_route.dart';
import 'screen/scanner_screen_route.dart';
import 'screen/splash_screen_route.dart';

class AccessRoute {
  static const screen = _ScreenRoute._();

  static const authenticate = AuthenticateAccessRoute();

  static const user = UserAccessRoute();

  static void splash(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const SplashScreenRoute(
        controller: SplashControllerRoute(),
      ),
    );
  }

  static void landing(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const LandingScreenRoute(
        controller: LandingControllerRoute(),
      ),
    );
  }

  static void dashboard(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const DashboardScreenRoute(
        controller: DashboardControllerRoute(),
      ),
    );
  }

  static void scanner(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: ScannerScreenRoute(
        controller: ScannerControllerRoute(),
      ),
    );
  }

  const AccessRoute._();
}

class _ScreenRoute {
  const _ScreenRoute._();

  Widget get splash => const SplashScreenRoute(
    controller: SplashControllerRoute(),
  );
}
