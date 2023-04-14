import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';

class UserSettingControllerRoute {
  const UserSettingControllerRoute();

  void viewProfile(final BuildContext context) {

  }

  void updatePassword(final BuildContext context) {

  }

  void viewTheme() {
    RouteDirectory.app.theme();
  }

  void viewLanguage() {
    RouteDirectory.app.language();
  }

  void signOut(final BuildContext context) async {
    await RepositoryDirectory.clear();

    if (!context.mounted) return;

    RouteDirectory.app.splash();
  }

  void deleteAccount(final BuildContext context) async {
    await RepositoryDirectory.clear();

    if (!context.mounted) return;

    RouteDirectory.app.splash();
  }
}
