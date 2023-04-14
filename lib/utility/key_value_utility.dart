import 'package:shared_preferences/shared_preferences.dart';

class KeyValueUtility {
  static Future<SharedPreferences> get _sharePreference => SharedPreferences.getInstance();

  static Future<int?> getInt(final String key) async {
    return (await _sharePreference).getInt(key);
  }

  static Future<bool?> getBool(final String key) async {
    return (await _sharePreference).getBool(key);
  }

  static Future<double?> getDouble(final String key) async {
    return (await _sharePreference).getDouble(key);
  }

  static Future<String?> getString(final String key) async {
    return (await _sharePreference).getString(key);
  }

  static Future<List<String>?> getStringList(final String key) async {
    return (await _sharePreference).getStringList(key);
  }


  static Future<bool> setInt(final String key, final int value) async {
    return await (await _sharePreference).setInt(key, value);
  }

  static Future<bool> setBool(final String key, final bool value) async {
    return await (await _sharePreference).setBool(key, value);
  }

  static Future<bool> setDouble(final String key, final double value) async {
    return await (await _sharePreference).setDouble(key, value);
  }

  static Future<bool> setString(final String key, final String value) async {
    return await (await _sharePreference).setString(key, value);
  }

  static Future<bool> setStringList(final String key, final List<String> value) async {
    return await (await _sharePreference).setStringList(key, value);
  }

  static Future<bool> clear() async {
    return (await _sharePreference).clear();
  }

  const KeyValueUtility._();
}
