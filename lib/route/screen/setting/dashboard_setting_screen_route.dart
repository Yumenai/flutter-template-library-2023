import 'package:flutter/material.dart';

import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../item/menu_item_component.dart';
import '../../../service/repository_service.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/navigator_utility.dart';
import '../entry/splash_entry_screen_route.dart';
import 'theme_setting_screen_route.dart';

class DashboardSettingScreenRoute extends StatelessWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const DashboardSettingScreenRoute(),
    );
  }

  final controller = const _ScreenController._();

  const DashboardSettingScreenRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateComponent(
      infoTitle: 'Settings',
      layout: ListView(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              ClipOval(
                child: SizedBox.square(
                  dimension: 100,
                  child: ImageViewComponent.asset(
                    AppController.listen(context).image.app.logo,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text(
                'Yumenai',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          MenuItemComponent(
            title: 'Profile',
            prefix: const Icon(Icons.person_2_outlined),
            onTap: () => controller.viewProfile(context),
          ),
          MenuItemComponent(
            title: 'Change Password',
            prefix: const Icon(Icons.password),
            onTap: () => controller.updatePassword(context),
          ),
          MenuItemComponent(
            title: 'Theme',
            prefix: const Icon(Icons.style_outlined),
            onTap: () => controller.viewTheme(context),
          ),
          MenuItemComponent(
            title: 'Language',
            prefix: const Icon(Icons.translate),
            onTap: () => controller.viewLanguage(context),
          ),
          const SizedBox(
            height: 50,
          ),
          MenuItemComponent(
            title: 'Sign Out',
            prefix: const Icon(Icons.exit_to_app_outlined),
            color: AppController.listen(context).color.error,
            onTap: () => controller.signOut(context),
          ),
          MenuItemComponent(
            title: 'Delete Account',
            prefix: const Icon(Icons.delete),
            color: AppController.listen(context).color.error,
            onTap: () => controller.deleteAccount(context),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppUtility.version),
                const Text(' ('),
                Text(AppUtility.code),
                const Text(')'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenController {
  const _ScreenController._();

  void viewProfile(final BuildContext context) {

  }

  void updatePassword(final BuildContext context) {

  }

  void viewTheme(final BuildContext context) {
    ThemeSettingScreenRoute.navigate(context);
  }

  void viewLanguage(final BuildContext context) {

  }

  void signOut(final BuildContext context) async {
    await RepositoryService.key.clear();

    if (!context.mounted) return;

    SplashEntryScreenRoute.navigate(context);
  }

  void deleteAccount(final BuildContext context) async {
    await RepositoryService.key.clear();

    if (!context.mounted) return;

    SplashEntryScreenRoute.navigate(context);
  }
}
