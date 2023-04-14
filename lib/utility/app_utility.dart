import 'package:package_info_plus/package_info_plus.dart';

class AppUtility {
  static Future<PackageInfo> get _packageInfo => PackageInfo.fromPlatform();

  static Future<String> get name async => (await _packageInfo).appName;

  static Future<String> get code async => (await _packageInfo).buildNumber;

  static Future<String> get version async => (await _packageInfo).version;

  const AppUtility._();
}
