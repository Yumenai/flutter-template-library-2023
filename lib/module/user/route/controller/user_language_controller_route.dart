import 'package:flutter/material.dart';

import '../../../../controller/app_controller.dart';
import '../../../../data/resource/language_resource_data.dart';

class UserLanguageControllerRoute {
  const UserLanguageControllerRoute();

  void viewItem(final BuildContext context, final int position) {
    AppController.of(context).updateLanguage(LanguageResourceData.supportedInformationList.keys.elementAt(position));
  }
}