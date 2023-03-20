import 'package:shared_preferences/shared_preferences.dart';

class KeyStorageUtility {
  static SharedPreferences? _sharePreference;

  static Future<void> initialise() async {
    _sharePreference ??= await SharedPreferences.getInstance();
  }

  static int? getInt(final String key, [
    final int? defaultValue,
  ]) {
    return _sharePreference?.getInt(key) ?? defaultValue;
  }

  static bool? getBool(final String key, [
    final bool? defaultValue,
  ]) {
    return _sharePreference?.getBool(key) ?? defaultValue;
  }

  static double? getDouble(final String key, [
    final double? defaultValue,
  ]) {
    return _sharePreference?.getDouble(key) ?? defaultValue;
  }

  static String? getString(final String key, [
    final String? defaultValue,
  ]) {
    return _sharePreference?.getString(key) ?? defaultValue;
  }

  static List<String>? getStringList(final String key, [
    final List<String>? defaultValue,
  ]) {
    return _sharePreference?.getStringList(key) ?? defaultValue;
  }


  static Future<bool> setInt(final String key, final int value) async {
    return await _sharePreference?.setInt(key, value) ?? false;
  }

  static Future<bool> setBool(final String key, final bool value) async {
    return await _sharePreference?.setBool(key, value) ?? false;
  }

  static Future<bool> setDouble(final String key, final double value) async {
    return await _sharePreference?.setDouble(key, value) ?? false;
  }

  static Future<bool> setString(final String key, final String value) async {
    return await _sharePreference?.setString(key, value) ?? false;
  }

  static Future<bool> setStringList(final String key, final List<String> value) async {
    return await _sharePreference?.setStringList(key, value) ?? false;
  }

  static Future<bool> clear() async {
    return await _sharePreference?.clear() ?? false;
  }

  const KeyStorageUtility._();
}
