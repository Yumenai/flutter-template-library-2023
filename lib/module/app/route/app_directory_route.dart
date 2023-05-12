import 'package:flutter/material.dart';

import '../../../model/route_model.dart';
import '../../../service/route_service.dart';
import 'controller/app_dashboard_controller_route.dart';
import 'controller/app_landing_controller_route.dart';
import 'controller/app_setting_controller_route.dart';
import 'controller/app_splash_controller_route.dart';
import 'screen/app_dashboard_screen_route.dart';
import 'screen/app_landing_screen_route.dart';
import 'screen/app_setting_screen_route.dart';
import 'screen/app_splash_screen_route.dart';

class AppDirectoryRoute {
  void Function() _viewSignIn = () {};
  void Function() _viewSignUp = () {};
  void Function() _viewProfileSettings = () {};
  void Function() _viewPasswordSettings = () {};
  void Function() _viewThemeSettings = () {};
  void Function() _viewLanguageSettings = () {};
  void Function() _viewAccountDeletion = () {};
  Future<bool> Function(BuildContext) _onSetup = (_) async => false;
  Future<void> Function() _onSignOut = () async {};

  void initialise({
    required final void Function() viewSignIn,
    required final void Function() viewSignUp,
    required final void Function() viewProfileSettings,
    required final void Function() viewPasswordSettings,
    required final void Function() viewThemeSettings,
    required final void Function() viewLanguageSettings,
    required final void Function() viewAccountDeletion,
    required final Future<bool> Function(BuildContext) onSetup,
    required final Future<void> Function() onSignOut,
  }) {
    _viewSignIn = viewSignIn;
    _viewSignUp = viewSignUp;
    _viewProfileSettings = viewProfileSettings;
    _viewPasswordSettings = viewPasswordSettings;
    _viewThemeSettings = viewThemeSettings;
    _viewLanguageSettings = viewLanguageSettings;
    _viewAccountDeletion = viewAccountDeletion;
    _onSetup = onSetup;
    _onSignOut = onSignOut;
  }

  RouteModel get splash => RouteModel(
    onBuild: () => AppSplashScreenRoute(
      controller: AppSplashControllerRoute(
        onSetup: _onSetup,
      ),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get landing => RouteModel(
    onBuild: () => AppLandingScreenRoute(
      controller: AppLandingControllerRoute(
        onSignIn: _viewSignIn,
        onSignUp: _viewSignUp,
      ),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get dashboard => RouteModel(
    onBuild: () => const AppDashboardScreenRoute(
      controller: AppDashboardControllerRoute(),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get settings => RouteModel(
    onBuild: () => AppSettingScreenRoute(
      controller: AppSettingControllerRoute(
        viewProfileSettings: _viewProfileSettings,
        viewPasswordSettings: _viewPasswordSettings,
        viewThemeSettings: _viewThemeSettings,
        viewLanguageSettings: _viewLanguageSettings,
        viewAccountDeletion: _viewAccountDeletion,
        onSignOut: _onSignOut,
      ),
    ),
    onNavigate: RouteService.push,
  );
}
