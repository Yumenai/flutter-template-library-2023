import '../../../model/route_model.dart';
import '../../../service/route_service.dart';
import 'controller/authenticate_user_controller_route.dart';
import 'screen/authenticate_user_screen_route.dart';

class AuthenticateDirectoryRoute {
  void Function() _viewSplash = () {};

  AuthenticateDirectoryRoute();

  void initialise({
    required final void Function() viewSplash,
  }) {
    _viewSplash = viewSplash;
  }

  RouteModel get user => RouteModel(
    screen: AuthenticateUserScreenRoute(
      controller: AuthenticateUserControllerRoute(
        viewSplash: _viewSplash,
      ),
    ),
    onNavigate: RouteService.pushBase,
  );
}
