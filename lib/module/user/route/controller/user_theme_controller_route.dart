import 'package:flutter/material.dart';

import '../../../../controller/app_controller.dart';

class UserThemeControllerRoute {
  const UserThemeControllerRoute();

  void updateTheme(final BuildContext context, final ThemeMode themeMode) {
    AppController.of(context).updateTheme(themeMode);
  }
}
