import '../../../model/route_model.dart';
import '../../../service/route_service.dart';
import 'controller/authentication_login_controller_route.dart';
import 'screen/authentication_login_screen_route.dart';

class AuthenticationDirectoryRoute {
  void Function() _viewSplash = () {};

  AuthenticationDirectoryRoute();

  void initialise({
    required final void Function() viewSplash,
  }) {
    _viewSplash = viewSplash;
  }

  RouteModel get user => RouteModel(
    screen: AuthenticationLoginScreenRoute(
      controller: AuthenticationLoginControllerRoute(
        viewSplash: _viewSplash,
      ),
    ),
    onNavigate: RouteService.push,
  );
}
