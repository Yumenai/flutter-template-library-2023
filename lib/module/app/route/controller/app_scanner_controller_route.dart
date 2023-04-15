import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AppScannerControllerRoute {
  final scannerController = MobileScannerController();

  AppScannerControllerRoute();

  void onScan(final BuildContext context, final String data) async {
    await scannerController.stop();

    if (data.trim().isEmpty) {
      await scannerController.start();
    } else if (context.mounted) {
      Navigator.pop(context, data);
    }
  }

  void toggleTorch() {
    scannerController.toggleTorch();
  }

  bool hasTorch() => scannerController.hasTorch;
}