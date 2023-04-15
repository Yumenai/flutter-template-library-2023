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

    final refreshToken = RepositoryDirectory.app?.sessionRefreshToken ?? '';

    if (!state.mounted) return;

    if (refreshToken.isEmpty) {
      RouteDirectory.app.navigator.landing();
    } else {
      RouteDirectory.app.navigator.dashboard();
    }
  }
}
