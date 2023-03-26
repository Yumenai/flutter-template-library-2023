import 'package:package_info_plus/package_info_plus.dart';

class AppService {
  static AppService? instance;

  static Future<void> initialise() async {
    instance ??= AppService._(await PackageInfo.fromPlatform());
  }

  final PackageInfo? _packageInfo;

  const AppService._(this._packageInfo);

  String get name => _packageInfo?.appName ?? '';

  String get code => _packageInfo?.buildNumber ?? '';

  String get version => _packageInfo?.version ?? '';
}
