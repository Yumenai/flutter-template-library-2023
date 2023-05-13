import 'package:flutter/material.dart';

import 'route/scanner_directory_route.dart';

class ScannerModule {
  static ScannerModule Function(BuildContext) _of = (context) => ScannerModule();

  static ScannerModule of(final BuildContext context) => _of(context);

  final directoryRoute = ScannerDirectoryRoute();

  ScannerModule();

  Future<void> initialise({
    required final ScannerModule Function(BuildContext) provider,
  }) async {
    _of = provider;
    directoryRoute.initialise();
  }

  Future<void> clear() async {}
}