import 'package:flutter/material.dart';

import '../../../../component/template/screen_template_component.dart';
import '../../../../controller/app_controller.dart';
import '../../../../data/resource/language_resource_data.dart';
import '../../../../item/menu_item_component.dart';
import '../controller/user_language_controller_route.dart';

class UserLanguageScreenRoute extends StatelessWidget {
  final UserLanguageControllerRoute controller;

  const UserLanguageScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateComponent(
      infoTitle: AppController.listen(context).text?.routeTitleLanguageSettings,
      layout: ListView.builder(
        itemCount: LanguageResourceData.supportedInformationList.length,
        itemBuilder: (context, position) {
          return MenuItemComponent(
            title: LanguageResourceData.supportedInformationList.values.elementAt(position),
            suffix: AppController.listen(context).locale.languageCode == LanguageResourceData.supportedInformationList.keys.elementAt(position) ? Icon(
              Icons.check,
              color: AppController.listen(context).color.primary,
            ) : const SizedBox.square(
              dimension: 24,
            ),
            onTap: () => controller.viewItem(context, position),
          );
        },
      ),
    );
  }
}
