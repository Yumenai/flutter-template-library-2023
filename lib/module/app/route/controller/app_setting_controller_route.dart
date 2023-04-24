import 'package:flutter/material.dart';

import '../../../../utility/dialog_utility.dart';
import '../../../../provider/app_provider.dart';
import '../../app_module.dart';

class AppSettingControllerRoute {
  final void Function() viewProfileSettings;
  final void Function() viewPasswordSettings;
  final void Function() viewThemeSettings;
  final void Function() viewLanguageSettings;
  final void Function() viewAccountDeletion;
  final Future<void> Function() onSignOut;

  const AppSettingControllerRoute({
    required this.viewProfileSettings,
    required this.viewPasswordSettings,
    required this.viewThemeSettings,
    required this.viewLanguageSettings,
    required this.viewAccountDeletion,
    required this.onSignOut,
  });

  void signOut(final BuildContext context) async {
    final isConfirm = await DialogUtility.showConfirm(
      context,
      title: 'Sign Out',
      message: 'Do you wish to sign out and clear all data within this application?',
      color: AppProvider.of(context).color.error,
      positiveTitle: 'Yes, Sign Out',
      negativeTitle: 'No, Cancel',
    );

    if (!isConfirm) return;

    await onSignOut();

    if (!context.mounted) return;

    AppModule.of(context).directoryRoute?.navigator.splash();
  }
}
