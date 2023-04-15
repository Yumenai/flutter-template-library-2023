import 'package:flutter/material.dart';

import '../../../../provider/app_provider.dart';
import '../../../../data/resource/language_resource_data.dart';

class UserLanguageControllerRoute {
  const UserLanguageControllerRoute();

  void viewItem(final BuildContext context, final int position) {
    AppProvider.of(context).updateLanguage(LanguageResourceData.supportedInformationList.keys.elementAt(position));
  }
}
