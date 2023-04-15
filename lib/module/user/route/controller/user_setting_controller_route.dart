import 'package:flutter/material.dart';

import '../../../../directory/dialog_directory.dart';
import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';
import '../../../../provider/app_provider.dart';

class UserSettingControllerRoute {
  const UserSettingControllerRoute();

  void viewProfile(final BuildContext context) {

  }

  void updatePassword(final BuildContext context) {

  }

  void viewTheme() {
    RouteDirectory.user.navigator.theme();
  }

  void viewLanguage() {
    RouteDirectory.user.navigator.language();
  }

  void signOut(final BuildContext context) async {
    final isConfirm = await DialogDirectory.showConfirm(
      context,
      title: 'Sign Out',
      message: 'Do you wish to sign out and clear all data within this application?',
      color: AppProvider.of(context).color.error,
      positiveTitle: 'Yes, Sign Out',
      negativeTitle: 'No, Cancel',
    );

    if (!isConfirm) return;

    await RepositoryDirectory.clear();

    if (!context.mounted) return;

    RouteDirectory.app.navigator.splash();
  }

  void deleteAccount(final BuildContext context) async {

  }
}
