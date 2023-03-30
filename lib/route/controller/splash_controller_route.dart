import 'package:flutter/material.dart';

import '../access_route.dart';
import '../../controller/repository_controller.dart';

class SplashControllerRoute {
  const SplashControllerRoute();

  void initialise(final State state) async {
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    if (!state.mounted) return;

    final accessToken = RepositoryController.instance.sessionRefreshToken;

    if (!state.mounted) return;

    if (accessToken.isEmpty) {
      AccessRoute.landing(state.context);
    } else {
      AccessRoute.dashboard(state.context);
    }
  }
}
