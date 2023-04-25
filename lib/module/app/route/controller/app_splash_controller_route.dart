import 'package:flutter/material.dart';

import '../../app_module.dart';

class AppSplashControllerRoute {
  final Future<bool> Function(BuildContext) onSetup;

  const AppSplashControllerRoute({
    required this.onSetup,
  });

  void initialise(final State state) async {
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    if (!state.mounted) return;

    final isUserAccessEnabled = await onSetup(state.context);

    if (!state.mounted) return;

    if (isUserAccessEnabled) {
      AppModule.of(state.context).directoryRoute.dashboard.navigate();
    } else {
      AppModule.of(state.context).directoryRoute.landing.navigate();
    }
  }
}
