import '../module/app/app_route.dart';
import '../module/authenticate/authenticate_route.dart';
import '../module/user/user_route.dart';

class RouteDirectory {
  static const app = AppRoute();
  static const authenticate = AuthenticateRoute();
  static const user = UserRoute();

  const RouteDirectory._();
}