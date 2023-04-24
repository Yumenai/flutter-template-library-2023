import 'package:flutter/material.dart';

import 'data/authenticate_repository_data.dart';
import 'route/authenticate_directory_route.dart';

class AuthenticateModule {
  static AuthenticateModule Function(BuildContext) _of = (context) => AuthenticateModule();

  static AuthenticateModule of(final BuildContext context) => _of(context);

  final repository = const AuthenticateRepositoryData();

  AuthenticateDirectoryRoute? directoryRoute;

  AuthenticateModule();

  void initialise({
    required final AuthenticateModule Function(BuildContext) provider,
    required final void Function() viewSplash,
  }) {
    _of = provider;
    directoryRoute = AuthenticateDirectoryRoute(
      viewSplash: viewSplash,
    );
  }

  Future<void> clear() async {
    await repository.clear();
  }
}