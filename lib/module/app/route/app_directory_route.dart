import 'package:flutter/material.dart';

import '../../../service/route_service.dart';
import 'controller/app_dashboard_controller_route.dart';
import 'controller/app_landing_controller_route.dart';
import 'controller/app_scanner_controller_route.dart';
import 'controller/app_setting_controller_route.dart';
import 'controller/app_splash_controller_route.dart';
import 'screen/app_dashboard_screen_route.dart';
import 'screen/app_landing_screen_route.dart';
import 'screen/app_scanner_screen_route.dart';
import 'screen/app_setting_screen_route.dart';
import 'screen/app_splash_screen_route.dart';

class AppDirectoryRoute {
  final AppScreenRoute screen;
  late final navigator = AppNavigatorRoute(screen);

  AppDirectoryRoute({
    required final void Function() viewSignIn,
    required final void Function() viewSignUp,
    required final void Function() viewProfileSettings,
    required final void Function() viewPasswordSettings,
    required final void Function() viewThemeSettings,
    required final void Function() viewLanguageSettings,
    required final void Function() viewAccountDeletion,
    required final Future<bool> Function(BuildContext) onSetup,
    required final Future<void> Function() onSignOut,
  }) :  screen = AppScreenRoute(
    viewSignIn,
    viewSignUp,
    viewProfileSettings,
    viewPasswordSettings,
    viewThemeSettings,
    viewLanguageSettings,
    viewAccountDeletion,
    onSetup,
    onSignOut,
  );
}

class AppNavigatorRoute {
  final AppScreenRoute _screen;

  const AppNavigatorRoute(this._screen);

  void splash() {
    RouteService.pushBase(_screen.splash);
  }

  void landing() {
    RouteService.pushBase(_screen.landing);
  }

  void dashboard() {
    RouteService.pushBase(_screen.dashboard);
  }

  void setting() {
    RouteService.push(_screen.setting);
  }

  void scanner() {
    RouteService.push(_screen.scanner);
  }
}

class AppScreenRoute {
  final void Function() _viewSignIn;
  final void Function() _viewSignUp;
  final void Function() _viewProfileSettings;
  final void Function() _viewPasswordSettings;
  final void Function() _viewThemeSettings;
  final void Function() _viewLanguageSettings;
  final void Function() _viewAccountDeletion;
  final Future<bool> Function(BuildContext) _onSetup;
  final Future<void> Function() _onSignOut;

  const AppScreenRoute(this._viewSignIn,
    this._viewSignUp,
    this._viewProfileSettings,
    this._viewPasswordSettings,
    this._viewThemeSettings,
    this._viewLanguageSettings,
    this._viewAccountDeletion,
    this._onSetup,
    this._onSignOut,
  );

  AppSplashScreenRoute get splash => AppSplashScreenRoute(
    controller: AppSplashControllerRoute(
      onSetup: _onSetup,
    ),
  );

  AppLandingScreenRoute get landing => AppLandingScreenRoute(
    controller: AppLandingControllerRoute(
      onSignIn: _viewSignIn,
      onSignUp: _viewSignUp,
    ),
  );

  AppDashboardScreenRoute get dashboard => const AppDashboardScreenRoute(
    controller: AppDashboardControllerRoute(),
  );

  AppSettingScreenRoute get setting => AppSettingScreenRoute(
    controller: AppSettingControllerRoute(
      viewProfileSettings: _viewProfileSettings,
      viewPasswordSettings: _viewPasswordSettings,
      viewThemeSettings: _viewThemeSettings,
      viewLanguageSettings: _viewLanguageSettings,
      viewAccountDeletion: _viewAccountDeletion,
      onSignOut: _onSignOut,
    ),
  );

  AppScannerScreenRoute get scanner => AppScannerScreenRoute(
    controller: AppScannerControllerRoute(),
  );
}
