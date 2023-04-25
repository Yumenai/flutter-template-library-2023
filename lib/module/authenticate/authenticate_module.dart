import 'package:flutter/material.dart';

import 'data/authenticate_repository_data.dart';
import 'route/authenticate_directory_route.dart';

class AuthenticateModule {
  static AuthenticateModule Function(BuildContext) _of = (context) => AuthenticateModule();

  static AuthenticateModule of(final BuildContext context) => _of(context);

  final repository = const AuthenticateRepositoryData();

  final directoryRoute = AuthenticateDirectoryRoute();

  AuthenticateModule();

  Future<void> initialise({
    required final AuthenticateModule Function(BuildContext) provider,
    required final void Function() viewSplash,
  }) async {
    _of = provider;
    directoryRoute.initialise(
      viewSplash: viewSplash,
    );
  }

  Future<void> clear() async {
    await repository.clear();
  }
}