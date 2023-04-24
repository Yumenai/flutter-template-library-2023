import 'package:flutter/material.dart';

import '../../model/user_profile_model.dart';

class UserMemoryDatasourceData {
  Locale? locale;
  ThemeMode? themeMode;

  String sessionAccessToken = '';
  UserProfileModel? profileModel;

  UserMemoryDatasourceData();

  Future<void> clear() async {
    locale = null;
    themeMode = null;
    sessionAccessToken = '';
    profileModel = null;
  }
}