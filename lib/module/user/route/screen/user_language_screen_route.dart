import 'package:flutter/material.dart';

import '../../../../view/template/screen_template_view.dart';
import '../../../../provider/app_provider.dart';
import '../../../../data/resource/language_resource_data.dart';
import '../../../../view/item/menu_item_view.dart';
import '../controller/user_language_controller_route.dart';

class UserLanguageScreenRoute extends StatelessWidget {
  final UserLanguageControllerRoute controller;

  const UserLanguageScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      infoTitle: AppProvider.listen(context).text?.routeTitleLanguageSettings,
      layout: ListView.builder(
        itemCount: LanguageResourceData.supportedInformationList.length,
        itemBuilder: (context, position) {
          return MenuItemView(
            title: LanguageResourceData.supportedInformationList.values.elementAt(position),
            suffix: AppProvider.listen(context).locale.languageCode == LanguageResourceData.supportedInformationList.keys.elementAt(position) ? Icon(
              Icons.check,
              color: AppProvider.listen(context).color.primary,
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
