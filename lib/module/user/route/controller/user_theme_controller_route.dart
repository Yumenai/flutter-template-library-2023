import 'package:flutter/material.dart';

import '../../../../controller/app_controller.dart';

class ThemeSettingControllerRoute {
  const ThemeSettingControllerRoute();

  void updateTheme(final BuildContext context, final ThemeMode themeMode) {
    AppController.of(context).updateTheme(themeMode);
  }
}
