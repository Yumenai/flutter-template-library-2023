import 'package:package_info_plus/package_info_plus.dart';

class AppUtility {
  static PackageInfo? _packageInfo;

  static Future<PackageInfo> get _instance async {
    return _packageInfo ??= await PackageInfo.fromPlatform();
  }

  static Future<String> get name async => (await _instance).appName;

  static Future<String> get code async => (await _instance).buildNumber;

  static Future<String> get version async => (await _instance).version;

  const AppUtility._();
}
