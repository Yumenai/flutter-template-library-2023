import 'package:flutter/material.dart';

import '../../../../controller/repository_controller.dart';
import '../../../../route/access_route.dart';

class DashboardSettingControllerRoute {
  const DashboardSettingControllerRoute();

  void viewProfile(final BuildContext context) {

  }

  void updatePassword(final BuildContext context) {

  }

  void viewTheme(final BuildContext context) {
    AccessRoute.user.theme(context);
  }

  void viewLanguage(final BuildContext context) {
    AccessRoute.user.language(context);
  }

  void signOut(final BuildContext context) async {
    await RepositoryController.instance.clear();

    if (!context.mounted) return;

    AccessRoute.splash(context);
  }

  void deleteAccount(final BuildContext context) async {
    await RepositoryController.instance.clear();

    if (!context.mounted) return;

    AccessRoute.splash(context);
  }
}
