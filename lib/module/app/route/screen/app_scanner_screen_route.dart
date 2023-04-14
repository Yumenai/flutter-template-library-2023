import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../view/template/screen_template_view.dart';
import '../controller/app_scanner_controller_route.dart';

class AppScannerScreenRoute extends StatelessWidget {
  final AppScannerControllerRoute controller;

  const AppScannerScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 2 / 3;

    return ScreenTemplateView(
      infoTitle: 'Scan QR Code',
      foregroundColor: Colors.white,
      enableOverlapHeader: true,
      layout: Stack(
        children: [
          MobileScanner(
            controller: controller.scannerController,
            onDetect: (capture) {
              if (capture.barcodes.isEmpty) return;

              controller.onScan(context, capture.barcodes.first.rawValue ?? '');
            },
          ),
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1.5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  height: size,
                  width: size,
                ),
              ),
            ),
          ),
        ],
      ),
      layoutAction: ValueListenableBuilder(
        valueListenable: controller.scannerController.hasTorchState,
        builder: (context, state, child) {
          if (state == true) {
            return FloatingActionButton(
              tooltip: 'Toggle Torchlight',
              child:  ValueListenableBuilder(
                valueListenable: controller.scannerController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off);
                    case TorchState.on:
                      return const Icon(Icons.flash_on);
                  }
                },
              ),
              onPressed: () => controller.toggleTorch(),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}