import 'package:flutter/material.dart';

import '../../../component/template/screen_template_component.dart';
import '../../../controller/app_controller.dart';
import '../../../data/resource/language_resource_data.dart';
import '../../../item/menu_item_component.dart';
import '../../../utility/navigator_utility.dart';

class LanguageSettingScreenRoute extends StatelessWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const LanguageSettingScreenRoute(),
    );
  }

  final controller = const _ScreenController._();

  const LanguageSettingScreenRoute({Key? key}) : super(key: key);

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

class _ScreenController {
  const _ScreenController._();

  void viewItem(final BuildContext context, final int position) {
    AppController.of(context).updateLanguage(LanguageResourceData.supportedInformationList.keys.elementAt(position));
  }
}
