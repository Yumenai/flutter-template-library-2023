import 'package:flutter/material.dart';

import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../item/menu_item_component.dart';
import '../../../service/app_service.dart';
import '../../controller/setting/dashboard_setting_controller_route.dart';

class DashboardSettingScreenRoute extends StatelessWidget {
  final DashboardSettingControllerRoute controller;

  const DashboardSettingScreenRoute({
    super.key,
    required this.controller,
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
                Text(AppService.instance?.version ?? ''),
                const Text(' ('),
                Text(AppService.instance?.code ?? ''),
                const Text(')'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
