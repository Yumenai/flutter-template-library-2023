import 'package:flutter/material.dart';

import '../../app_module.dart';

class AppSplashControllerRoute {
  final Future<String> Function() getSessionRefreshToken;

  const AppSplashControllerRoute({
    required this.getSessionRefreshToken,
  });

  void initialise(final State state) async {
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    if (!state.mounted) return;

    final refreshToken = await getSessionRefreshToken();

    if (!state.mounted) return;

    if (refreshToken.isEmpty) {
      AppModule.of(state.context).directoryRoute?.navigator.landing();
    } else {
      AppModule.of(state.context).directoryRoute?.navigator.dashboard();
    }
  }
}
