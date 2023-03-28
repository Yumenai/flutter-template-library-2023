import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import 'controller/user_language_controller_route.dart';
import 'controller/user_setting_controller_route.dart';
import 'controller/user_theme_controller_route.dart';
import 'screen/user_language_screen_route.dart';
import 'screen/user_setting_screen_route.dart';
import 'screen/user_theme_screen_route.dart';

class UserAccessRoute {
  const UserAccessRoute();

  void dashboard(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const UserSettingScreenRoute(
        controller: DashboardSettingControllerRoute(),
      ),
    );
  }

  void theme(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const UserThemeScreenRoute(
        controller: ThemeSettingControllerRoute(),
      ),
    );
  }

  void language(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const UserLanguageScreenRoute(
        controller: UserLanguageControllerRoute(),
      ),
    );
  }
}
