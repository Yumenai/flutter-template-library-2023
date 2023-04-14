import 'package:flutter/material.dart';

import '../../../../provider/app_provider.dart';

class AppThemeControllerRoute {
  const AppThemeControllerRoute();

  void updateTheme(final BuildContext context, final ThemeMode themeMode) {
    AppProvider.of(context).updateTheme(themeMode);
  }
}
