import 'package:flutter/material.dart';

import '../../../../view/template/screen_template_view.dart';
import '../../../../component/view/image_view_component.dart';
import '../../../../provider/app_provider.dart';
import '../../../../view/item/menu_item_view.dart';
import '../../../../utility/app_utility.dart';
import '../controller/user_setting_controller_route.dart';

class UserSettingScreenRoute extends StatelessWidget {
  final UserSettingControllerRoute controller;

  const UserSettingScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
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
                    AppProvider.listen(context).image.appLogo,
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
          MenuItemView(
            title: 'Profile',
            prefix: const Icon(Icons.person_2_outlined),
            onTap: () => controller.viewProfile(context),
          ),
          MenuItemView(
            title: 'Change Password',
            prefix: const Icon(Icons.password),
            onTap: () => controller.updatePassword(context),
          ),
          MenuItemView(
            title: 'Theme',
            prefix: const Icon(Icons.style_outlined),
            onTap: controller.viewTheme,
          ),
          MenuItemView(
            title: 'Language',
            prefix: const Icon(Icons.translate),
            onTap: controller.viewLanguage,
          ),
          const SizedBox(
            height: 50,
          ),
          MenuItemView(
            title: 'Sign Out',
            prefix: const Icon(Icons.exit_to_app_outlined),
            color: AppProvider.listen(context).color.error,
            onTap: () => controller.signOut(context),
          ),
          MenuItemView(
            title: 'Delete Account',
            prefix: const Icon(Icons.delete),
            color: AppProvider.listen(context).color.error,
            onTap: () => controller.deleteAccount(context),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: AppUtility.version,
                  builder: (context, asyncSnapshot) {
                    return Text(asyncSnapshot.data ?? '');
                  },
                ),
                const Text(' ('),
                FutureBuilder(
                  future: AppUtility.code,
                  builder: (context, asyncSnapshot) {
                    return Text(asyncSnapshot.data ?? '');
                  },
                ),
                const Text(')'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
