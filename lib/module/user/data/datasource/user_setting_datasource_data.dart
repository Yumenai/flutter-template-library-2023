import 'package:flutter/material.dart';

import '../../../../utility/key_value_utility.dart';

const _themeKey = 'theme';
const _themeDarkValue = 1;
const _themeLightValue = 2;
const _themeSystemValue = 3;

const _languageKey = 'language';

class UserSettingDatasourceData {
  const UserSettingDatasourceData();

  Future<ThemeMode?> getThemeMode() async {
    switch(await KeyValueUtility.getInt(_themeKey)) {
      case _themeDarkValue:
        return ThemeMode.dark;
      case _themeLightValue:
        return ThemeMode.light;
      case _themeSystemValue:
        return ThemeMode.system;
    }

    return null;
  }

  Future<String> getLanguageCode() async {
    return await KeyValueUtility.getString(_languageKey) ?? '';
  }



  Future<bool> setThemeMode(final ThemeMode themeMode) {
    final int themeCode;

    switch(themeMode) {
      case ThemeMode.dark:
        themeCode = _themeDarkValue;
        break;
      case ThemeMode.light:
        themeCode = _themeLightValue;
        break;
      case ThemeMode.system:
        themeCode = _themeSystemValue;
        break;
    }

    return KeyValueUtility.setInt(_themeKey, themeCode);
  }

  Future<bool> setLanguageCode(final String languageCode) {
    return KeyValueUtility.setString(_languageKey, languageCode);
  }


  Future<void> clear() async {
    await KeyValueUtility.clear();
  }
}