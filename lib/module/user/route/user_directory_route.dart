import '../../../model/route_model.dart';
import '../../../service/route_service.dart';
import 'controller/user_deletion_controller_route.dart';
import 'controller/user_language_controller_route.dart';
import 'controller/user_password_controller_route.dart';
import 'controller/user_profile_controller_route.dart';
import 'controller/user_registration_controller_route.dart';
import 'controller/user_theme_controller_route.dart';
import 'screen/user_deletion_screen_route.dart';
import 'screen/user_language_screen_route.dart';
import 'screen/user_password_screen_route.dart';
import 'screen/user_profile_screen_route.dart';
import 'screen/user_registration_screen_route.dart';
import 'screen/user_theme_screen_route.dart';

class UserDirectoryRoute {
  void Function() _viewSplash = () {};
  Future<void> Function() _onDeleteAccount = () async {};

  void initialise({
    required final void Function() viewSplash,
    required final Future<void> Function() onDeleteAccount,
  }) {
    _viewSplash = viewSplash;
    _onDeleteAccount = onDeleteAccount;
  }

  RouteModel get registration => RouteModel(
    screen: UserRegistrationScreenRoute(
      controller: UserRegistrationControllerRoute(),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get profile => RouteModel(
    screen: UserProfileScreenRoute(
      controller: UserProfileControllerRoute(),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get password => RouteModel(
    screen: UserPasswordScreenRoute(
      controller: UserPasswordControllerRoute(),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get theme => const RouteModel(
    screen: UserThemeScreenRoute(
      controller: UserThemeControllerRoute(),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get language => const RouteModel(
    screen: UserLanguageScreenRoute(
      controller: UserLanguageControllerRoute(),
    ),
    onNavigate: RouteService.pushBase,
  );

  RouteModel get deletion => RouteModel(
    screen: UserDeletionScreenRoute(
      controller: UserDeletionControllerRoute(
        viewSplash: _viewSplash,
        onDeleteAccount: _onDeleteAccount,
      ),
    ),
    onNavigate: RouteService.pushBase,
  );
}
