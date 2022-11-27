import 'package:shared_preferences/shared_preferences.dart';

class KeyRepositoryService {
  static Future<KeyRepositoryService> setup() async {
    return KeyRepositoryService._(
      await SharedPreferences.getInstance(),
    );
  }

  final SharedPreferences _sharedPreferences;

  const KeyRepositoryService._(this._sharedPreferences);


  int? getInt(final String key, [
    final int? defaultValue,
  ]) {
    return _sharedPreferences.getInt(key) ?? defaultValue;
  }

  bool? getBool(final String key, [
    final bool? defaultValue,
  ]) {
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

  double? getDouble(final String key, [
    final double? defaultValue,
  ]) {
    return _sharedPreferences.getDouble(key) ?? defaultValue;
  }

  String? getString(final String key, [
    final String? defaultValue,
  ]) {
    return _sharedPreferences.getString(key) ?? defaultValue;
  }

  List<String>? getStringList(final String key, [
    final List<String>? defaultValue,
  ]) {
    return _sharedPreferences.getStringList(key) ?? defaultValue;
  }


  Future<bool> setInt(final String key, final int value) {
    return _sharedPreferences.setInt(key, value);
  }

  Future<bool> setBool(final String key, final bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  Future<bool> setDouble(final String key, final double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  Future<bool> setString(final String key, final String value) {
    return _sharedPreferences.setString(key, value);
  }

  Future<bool> setStringList(final String key, final List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
