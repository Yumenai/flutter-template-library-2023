import 'package:flutter/material.dart';

import '../../../component/template/screen_template_component.dart';
import '../../../controller/app_controller.dart';
import '../../../item/menu_item_component.dart';
import '../../../utility/navigator_utility.dart';

class ThemeSettingScreenRoute extends StatelessWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const ThemeSettingScreenRoute(),
    );
  }

  final controller = const _ScreenController._();

  const ThemeSettingScreenRoute({Key? key}) : super(key: key);

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

class _ScreenController {
  const _ScreenController._();

  void updateTheme(final BuildContext context, final ThemeMode themeMode) {
    AppController.of(context).updateTheme(themeMode);
  }
}
