import '../../../service/route_service.dart';
import 'controller/authenticate_user_controller_route.dart';
import 'screen/authenticate_user_screen_route.dart';

class AuthenticateDirectoryRoute {
  final AuthenticateNavigatorRoute navigator;

  AuthenticateDirectoryRoute({
    required final void Function() viewSplash,
  }) :  navigator = AuthenticateNavigatorRoute(viewSplash);
}

class AuthenticateNavigatorRoute {
  final void Function() _viewSplash;

  const AuthenticateNavigatorRoute(
    this._viewSplash,
  );

  void user() {
    RouteService.push(AuthenticateUserScreenRoute(
      controller: AuthenticateUserControllerRoute(
        viewSplash: _viewSplash,
      ),
    ));
  }
}
