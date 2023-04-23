import 'package:flutter/material.dart';

import 'data/app_repository_data.dart';
import 'route/app_directory_route.dart';

class AppMaster {
  static AppMaster Function(BuildContext) of = (context) => AppMaster();

  final repository = const AppRepositoryData();

  AppDirectoryRoute? directoryRoute;

  AppMaster();

  void initialise({
    required final AppMaster Function(BuildContext) provider,
    required final void Function() viewSignIn,
    required final void Function() viewSignUp,
    required final void Function() viewProfileSettings,
    required final void Function() viewPasswordSettings,
    required final void Function() viewThemeSettings,
    required final void Function() viewLanguageSettings,
    required final void Function() viewAccountDeletion,
    required final Future<String> Function() getSessionRefreshToken,
    required final Future<void> Function() onSignOut,
  }) {
    of = provider;
    directoryRoute = AppDirectoryRoute(
      viewSignIn: viewSignIn,
      viewSignUp: viewSignUp,
      viewProfileSettings: viewProfileSettings,
      viewPasswordSettings: viewPasswordSettings,
      viewThemeSettings: viewThemeSettings,
      viewLanguageSettings: viewLanguageSettings,
      viewAccountDeletion: viewAccountDeletion,
      getSessionRefreshToken: getSessionRefreshToken,
      onSignOut: onSignOut,
    );
  }
}