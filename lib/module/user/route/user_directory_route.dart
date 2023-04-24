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
  final UserNavigatorRoute navigator;

  UserDirectoryRoute({
    required final void Function() viewSplash,
    required final Future<void> Function() onDeleteAccount,
  }) :  navigator = UserNavigatorRoute(
    viewSplash,
    onDeleteAccount,
  );
}

class UserNavigatorRoute {
  final void Function() _viewSplash;
  final Future<void> Function() onDeleteAccount;

  const UserNavigatorRoute(
    this._viewSplash,
    this.onDeleteAccount,
  );

  void registration() {
    RouteService.push(UserRegistrationScreenRoute(
      controller: UserRegistrationControllerRoute(),
    ));
  }

  void profile() {
    RouteService.push(UserProfileScreenRoute(
      controller: UserProfileControllerRoute(),
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

  void delete() {
    RouteService.push(UserDeletionScreenRoute(
      controller: UserDeletionControllerRoute(
        viewSplash: _viewSplash,
        onDeleteAccount: onDeleteAccount,
      ),
    ));
  }
}