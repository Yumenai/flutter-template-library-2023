import '../../utility/route_utility.dart';
import 'route/controller/authenticate_user_controller_route.dart';
import 'route/screen/authenticate_user_screen_route.dart';

class AuthenticateRoute {
  const AuthenticateRoute();

  void user() {
    RouteUtility.push(AuthenticateUserScreenRoute(
      controller: AuthenticationUserControllerRoute(),
    ));
  }
}
