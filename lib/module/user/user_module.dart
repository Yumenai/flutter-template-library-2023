import 'package:flutter/material.dart';

import 'data/user_repository_data.dart';
import 'route/user_directory_route.dart';

class UserModule {
  static UserModule Function(BuildContext) _of = (context) => UserModule();

  static UserModule of(final BuildContext context) => _of(context);

  final repository = UserRepositoryData();

  UserDirectoryRoute? directoryRoute;

  Future<String> Function() _getSessionRefreshToken = () async => '';

  UserModule();

  Future<void> initialise({
    required final UserModule Function(BuildContext) provider,
    required final void Function() viewSplash,
    required final Future<void> Function() onDeleteAccount,
    required final Future<String> Function() getSessionRefreshToken,
  }) async {
    _of = provider;
    directoryRoute = UserDirectoryRoute(
      viewSplash: viewSplash,
      onDeleteAccount: onDeleteAccount,
    );
    await repository.initialise();

    _getSessionRefreshToken = getSessionRefreshToken;
  }

  Future<bool> startup(final BuildContext context) async {
    await repository.setup(
      context,
      sessionRefreshToken: await _getSessionRefreshToken(),
    );

    return repository.sessionAccessToken.isNotEmpty;
  }

  Future<void> clear() async {
    await repository.clear();
  }
}