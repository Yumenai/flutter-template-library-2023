import 'package:flutter/material.dart';

import '../../../service/repository_service.dart';
import '../../access_route.dart';

class DashboardSettingControllerRoute {
  const DashboardSettingControllerRoute();

  void viewProfile(final BuildContext context) {

  }

  void updatePassword(final BuildContext context) {

  }

  void viewTheme(final BuildContext context) {
    AccessRoute.setting.theme(context);
  }

  void viewLanguage(final BuildContext context) {
    AccessRoute.setting.language(context);
  }

  void signOut(final BuildContext context) async {
    await RepositoryService.key.clear();

    if (!context.mounted) return;

    AccessRoute.splash(context);
  }

  void deleteAccount(final BuildContext context) async {
    await RepositoryService.key.clear();

    if (!context.mounted) return;

    AccessRoute.splash(context);
  }
}
