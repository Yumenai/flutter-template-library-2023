import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';

class AppSplashControllerRoute {
  const AppSplashControllerRoute();

  void initialise(final State state) async {
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    if (!state.mounted) return;

    final accessToken = RepositoryDirectory.app?.sessionAccessToken ?? '';

    if (!state.mounted) return;

    if (accessToken.isEmpty) {
      RouteDirectory.app.landing();
    } else {
      RouteDirectory.app.dashboard();
    }
  }
}
