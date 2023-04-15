import 'package:flutter/material.dart';

import '../../../../view/template/screen_template_view.dart';
import '../../../../provider/app_provider.dart';
import '../../../../view/item/menu_item_view.dart';
import '../controller/user_theme_controller_route.dart';

class UserThemeScreenRoute extends StatelessWidget {
  final UserThemeControllerRoute controller;

  const UserThemeScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      infoTitle: 'Theme Settings',
      layout: ListView(
        children: [
          MenuItemView(
            title: 'System',
            subtitle: 'Follow system theme settings',
            suffix: AppProvider.listen(context).themeMode == ThemeMode.system ? Icon(
              Icons.check,
              color: AppProvider.listen(context).color.primary,
            ) : const SizedBox.square(
              dimension: 24,
            ),
            onTap: () => controller.updateTheme(context, ThemeMode.system),
          ),
          MenuItemView(
            title: 'Light',
            subtitle: 'Enforce light theme regardless of system settings',
            suffix: AppProvider.listen(context).themeMode == ThemeMode.light ? Icon(
              Icons.check,
              color: AppProvider.listen(context).color.primary,
            ) : const SizedBox.square(
              dimension: 24,
            ),
            onTap: () => controller.updateTheme(context, ThemeMode.light),
          ),
          MenuItemView(
            title: 'Dark',
            subtitle: 'Enforce dark theme regardless of system settings',
            suffix: AppProvider.listen(context).themeMode == ThemeMode.dark ? Icon(
              Icons.check,
              color: AppProvider.listen(context).color.primary,
            ) : const SizedBox.square(
              dimension: 24,
            ),
            onTap: () => controller.updateTheme(context, ThemeMode.dark),
          ),
        ],
      )
    );
  }
}
