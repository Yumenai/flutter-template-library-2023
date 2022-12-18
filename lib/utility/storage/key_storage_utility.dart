import 'package:shared_preferences/shared_preferences.dart';

class KeyStorageUtility {
  static SharedPreferences? _sharePreference;

  static Future<SharedPreferences> get _instance async {
    return _sharePreference ??= await SharedPreferences.getInstance();
  }

  static Future<int?> getInt(final String key, [
    final int? defaultValue,
  ]) async {
    return (await _instance).getInt(key) ?? defaultValue;
  }

  static Future<bool?> getBool(final String key, [
    final bool? defaultValue,
  ]) async {
    return (await _instance).getBool(key) ?? defaultValue;
  }

  static Future<double?> getDouble(final String key, [
    final double? defaultValue,
  ]) async {
    return (await _instance).getDouble(key) ?? defaultValue;
  }

  static Future<String?> getString(final String key, [
    final String? defaultValue,
  ]) async {
    return (await _instance).getString(key) ?? defaultValue;
  }

  static Future<List<String>?> getStringList(final String key, [
    final List<String>? defaultValue,
  ]) async {
    return (await _instance).getStringList(key) ?? defaultValue;
  }


  static Future<bool> setInt(final String key, final int value) async {
    return (await _instance).setInt(key, value);
  }

  static Future<bool> setBool(final String key, final bool value) async {
    return (await _instance).setBool(key, value);
  }

  static Future<bool> setDouble(final String key, final double value) async {
    return (await _instance).setDouble(key, value);
  }

  static Future<bool> setString(final String key, final String value) async {
    return (await _instance).setString(key, value);
  }

  static Future<bool> setStringList(final String key, final List<String> value) async {
    return (await _instance).setStringList(key, value);
  }

  static Future<bool> clear() async {
    return (await _instance).clear();
  }

  const KeyStorageUtility._();
}
