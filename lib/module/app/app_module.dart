import 'package:flutter/material.dart';

import 'data/app_repository_data.dart';
import 'route/app_directory_route.dart';

class AppModule {
  static AppModule Function(BuildContext) _of = (context) => AppModule();

  static AppModule of(final BuildContext context) => _of(context);

  final repository = const AppRepositoryData();

  AppDirectoryRoute? directoryRoute;

  AppModule();

  void initialise({
    required final AppModule Function(BuildContext) provider,
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
    _of = provider;
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

  Future<void> clear() async {
    await repository.clear();
  }
}