import '../../utility/route_utility.dart';
import 'route/controller/user_password_controller_route.dart';
import 'route/controller/user_registration_controller_route.dart';
import 'route/controller/user_setting_controller_route.dart';
import 'route/screen/user_password_screen_route.dart';
import 'route/screen/user_registration_screen_route.dart';
import 'route/screen/user_setting_screen_route.dart';

class UserRoute {
  final navigator = const _UserNavigatorRoute();

  const UserRoute();
}

class _UserNavigatorRoute {
  const _UserNavigatorRoute();

  void registration() {
    RouteUtility.push(UserRegistrationScreenRoute(
      controller: UserRegistrationControllerRoute(),
    ));
  }

  void setting() {
    RouteUtility.push(const UserSettingScreenRoute(
      controller: UserSettingControllerRoute(),
    ));
  }

  void password() {
    RouteUtility.push(UserPasswordScreenRoute(
      controller: UserPasswordControllerRoute(),
    ));
  }
}