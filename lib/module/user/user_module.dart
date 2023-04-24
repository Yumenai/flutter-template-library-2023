import 'package:flutter/material.dart';

import 'data/user_repository_data.dart';
import 'route/user_directory_route.dart';

class UserModule {
  static UserModule Function(BuildContext) _of = (context) => UserModule();

  static UserModule of(final BuildContext context) => _of(context);

  final repository = const UserRepositoryData();

  UserDirectoryRoute? directoryRoute;

  UserModule();

  void initialise({
    required final UserModule Function(BuildContext) provider,
    required final void Function() viewSplash,
    required final Future<void> Function() onDeleteAccount,
  }) {
    _of = provider;
    directoryRoute = UserDirectoryRoute(
      viewSplash: viewSplash,
      onDeleteAccount: onDeleteAccount,
    );
  }

  Future<void> clear() async {
    await repository.clear();
  }
}