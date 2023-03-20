import 'package:package_info_plus/package_info_plus.dart';

class AppUtility {
  static PackageInfo? _packageInfo;

  static String get name => _packageInfo?.appName ?? '';

  static String get code => _packageInfo?.buildNumber ?? '';

  static String get version => _packageInfo?.version ?? '';

  static Future<void> initialise() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
  }

  const AppUtility._();
}
