import 'package:flutter/material.dart';

import 'data/authenticate_repository_data.dart';
import 'route/authenticate_directory_route.dart';

class AuthenticateMaster {
  static AuthenticateMaster Function(BuildContext) of = (context) => AuthenticateMaster();

  final repository = const AuthenticateRepositoryData();

  AuthenticateDirectoryRoute? directoryRoute;

  AuthenticateMaster();

  void initialise({
    required final AuthenticateMaster Function(BuildContext) provider,
    required final void Function() viewSplash,
  }) {
    of = provider;
    directoryRoute = AuthenticateDirectoryRoute(
      viewSplash: viewSplash,
    );
  }

  Future<void> clear() async {}
}