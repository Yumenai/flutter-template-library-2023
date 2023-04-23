import '../../../service/route_service.dart';
import 'controller/user_language_controller_route.dart';
import 'controller/user_password_controller_route.dart';
import 'controller/user_registration_controller_route.dart';
import 'controller/user_theme_controller_route.dart';
import 'screen/user_language_screen_route.dart';
import 'screen/user_password_screen_route.dart';
import 'screen/user_registration_screen_route.dart';
import 'screen/user_theme_screen_route.dart';

class UserDirectoryRoute {
  final navigator = const _UserNavigatorRoute();

  const UserDirectoryRoute();
}

class _UserNavigatorRoute {
  const _UserNavigatorRoute();

  void registration() {
    RouteService.push(UserRegistrationScreenRoute(
      controller: UserRegistrationControllerRoute(),
    ));
  }

  void password() {
    RouteService.push(UserPasswordScreenRoute(
      controller: UserPasswordControllerRoute(),
    ));
  }

  void theme() {
    RouteService.push(const UserThemeScreenRoute(
      controller: UserThemeControllerRoute(),
    ));
  }

  void language() {
    RouteService.push(const UserLanguageScreenRoute(
      controller: UserLanguageControllerRoute(),
    ));
  }
}