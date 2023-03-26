import 'package:flutter/material.dart';

import '../utility/navigator_utility.dart';
import 'controller/authenticate_controller_route.dart';
import 'controller/dashboard_controller_route.dart';
import 'controller/landing_controller_route.dart';
import 'controller/register_controller_route.dart';
import 'controller/setting/dashboard_setting_controller_route.dart';
import 'controller/setting/language_setting_controller_route.dart';
import 'controller/setting/theme_setting_controller_route.dart';
import 'controller/splash_controller_route.dart';
import 'screen/authenticate_screen_route.dart';
import 'screen/dashboard_screen_route.dart';
import 'screen/landing_screen_route.dart';
import 'screen/register_screen_route.dart';
import 'screen/setting/dashboard_setting_screen_route.dart';
import 'screen/setting/language_setting_screen_route.dart';
import 'screen/setting/theme_setting_screen_route.dart';
import 'screen/splash_screen_route.dart';

class AccessRoute {
  static const screen = _ScreenRoute._();
  static const setting = _SettingRoute._();

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

  static void authenticate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: AuthenticateScreenRoute(
        controller: AuthenticationControllerRoute(),
      ),
    );
  }

  static void register(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: RegisterScreenRoute(
        controller: RegisterControllerRoute(),
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

  const AccessRoute._();
}

class _ScreenRoute {
  const _ScreenRoute._();

  Widget get splash => const SplashScreenRoute(
    controller: SplashControllerRoute(),
  );
}

class _SettingRoute {
  const _SettingRoute._();

  void dashboard(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const DashboardSettingScreenRoute(
        controller: DashboardSettingControllerRoute(),
      ),
    );
  }

  void theme(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const ThemeSettingScreenRoute(
        controller: ThemeSettingControllerRoute(),
      ),
    );
  }

  void language(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const LanguageSettingScreenRoute(
        controller: LanguageSettingControllerRoute(),
      ),
    );
  }
}