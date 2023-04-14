import '../../utility/route_utility.dart';
import 'route/controller/app_dashboard_controller_route.dart';
import 'route/controller/app_landing_controller_route.dart';
import 'route/controller/app_language_controller_route.dart';
import 'route/controller/app_scanner_controller_route.dart';
import 'route/controller/app_splash_controller_route.dart';
import 'route/controller/app_theme_controller_route.dart';
import 'route/screen/app_dashboard_screen_route.dart';
import 'route/screen/app_landing_screen_route.dart';
import 'route/screen/app_language_screen_route.dart';
import 'route/screen/app_scanner_screen_route.dart';
import 'route/screen/app_splash_screen_route.dart';
import 'route/screen/app_theme_screen_route.dart';

class AppRoute {
  const AppRoute();

  void splash() {
    RouteUtility.pushBase(const AppSplashScreenRoute(
      controller: AppSplashControllerRoute(),
    ));
  }

  void landing() {
    RouteUtility.pushBase(const AppLandingScreenRoute(
      controller: AppLandingControllerRoute(),
    ));
  }

  void dashboard() {
    RouteUtility.pushBase(const AppDashboardScreenRoute(
      controller: AppDashboardControllerRoute(),
    ));
  }

  void theme() {
    RouteUtility.push(const AppThemeScreenRoute(
      controller: AppThemeControllerRoute(),
    ));
  }

  void language() {
    RouteUtility.push(const AppLanguageScreenRoute(
      controller: AppLanguageControllerRoute(),
    ));
  }

  void scanner() {
    RouteUtility.push(AppScannerScreenRoute(
      controller: AppScannerControllerRoute(),
    ));
  }
}
