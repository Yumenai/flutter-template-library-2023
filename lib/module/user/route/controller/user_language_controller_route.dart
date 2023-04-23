import 'package:flutter/material.dart';

import '../../../../provider/app_provider.dart';
import '../../../../data/variable/language_variable_data.dart';

class UserLanguageControllerRoute {
  const UserLanguageControllerRoute();

  void viewItem(final BuildContext context, final int position) {
    AppProvider.of(context).updateLanguage(LanguageVariableData.values.elementAt(position).code);
  }
}
