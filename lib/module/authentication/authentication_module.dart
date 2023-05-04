import 'package:flutter/material.dart';

import 'data/authentication_repository_data.dart';
import 'route/authentication_directory_route.dart';

class AuthenticationModule {
  static AuthenticationModule Function(BuildContext) _of = (context) => AuthenticationModule();

  static AuthenticationModule of(final BuildContext context) => _of(context);

  final repository = const AuthenticationRepositoryData();

  final directoryRoute = AuthenticationDirectoryRoute();

  AuthenticationModule();

  Future<void> initialise({
    required final AuthenticationModule Function(BuildContext) provider,
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