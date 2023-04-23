import 'package:flutter/material.dart';

import 'data/user_repository_data.dart';
import 'route/user_directory_route.dart';

class UserMaster {
  static UserMaster Function(BuildContext) of = (context) => UserMaster();

  final repository = const UserRepositoryData();

  UserDirectoryRoute? directoryRoute;

  UserMaster();

  void initialise({
    required final UserMaster Function(BuildContext) provider,
    required final void Function() viewSplash,
  }) {
    of = provider;
    directoryRoute = const UserDirectoryRoute();
  }

  Future<void> clear() async {}
}