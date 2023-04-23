import 'package:flutter/material.dart';

import '../../../../view/template/screen_template_view.dart';
import '../../../../provider/app_provider.dart';
import '../../../../data/variable/language_variable_data.dart';
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
        itemCount: LanguageVariableData.values.length,
        itemBuilder: (context, position) {
          return MenuItemView(
            title: LanguageVariableData.values.elementAt(position).name,
            suffix: AppProvider.listen(context).locale.languageCode == LanguageVariableData.values.elementAt(position).code ? Icon(
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
