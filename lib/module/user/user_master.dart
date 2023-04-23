import 'package:flutter/material.dart';

import 'data/user_repository_data.dart';
import 'route/user_directory_route.dart';

class UserMaster {
  static UserMaster Function(BuildContext) _of = (context) => UserMaster();

  static UserMaster of(final BuildContext context) => _of(context);

  final repository = const UserRepositoryData();

  UserDirectoryRoute? directoryRoute;

  UserMaster();

  void initialise({
    required final UserMaster Function(BuildContext) provider,
    required final void Function() viewSplash,
  }) {
    _of = provider;
    directoryRoute = const UserDirectoryRoute();
  }

  Future<void> clear() async {}
}