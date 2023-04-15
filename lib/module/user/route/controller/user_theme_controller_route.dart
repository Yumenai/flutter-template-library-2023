import 'package:flutter/material.dart';

import '../../../../provider/app_provider.dart';

class UserThemeControllerRoute {
  const UserThemeControllerRoute();

  void updateTheme(final BuildContext context, final ThemeMode themeMode) {
    AppProvider.of(context).updateTheme(themeMode);
  }
}
