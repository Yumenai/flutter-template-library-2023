import 'package:flutter/material.dart';

import '../../../../component/template/screen_template_component.dart';
import '../../../../controller/app_controller.dart';
import '../../../../item/menu_item_component.dart';
import '../controller/user_theme_controller_route.dart';

class UserThemeScreenRoute extends StatelessWidget {
  final UserThemeControllerRoute controller;

  const UserThemeScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateComponent(
      infoTitle: 'Theme Settings',
      layout: ListView(
        children: [
          MenuItemComponent(
            title: 'System',
            subtitle: 'Follow system theme settings',
            suffix: AppController.listen(context).themeMode == ThemeMode.system ? Icon(
              Icons.check,
              color: AppController.listen(context).color.primary,
            ) : const SizedBox.square(
              dimension: 24,
            ),
            onTap: () => controller.updateTheme(context, ThemeMode.system),
          ),
          MenuItemComponent(
            title: 'Light',
            subtitle: 'Enforce light theme regardless of system settings',
            suffix: AppController.listen(context).themeMode == ThemeMode.light ? Icon(
              Icons.check,
              color: AppController.listen(context).color.primary,
            ) : const SizedBox.square(
              dimension: 24,
            ),
            onTap: () => controller.updateTheme(context, ThemeMode.light),
          ),
          MenuItemComponent(
            title: 'Dark',
            subtitle: 'Enforce dark theme regardless of system settings',
            suffix: AppController.listen(context).themeMode == ThemeMode.dark ? Icon(
              Icons.check,
              color: AppController.listen(context).color.primary,
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
