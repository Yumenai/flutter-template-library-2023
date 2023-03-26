import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../component/template/screen_template_component.dart';
import '../utility/navigator_utility.dart';

class ScannerDialogRoute extends StatefulWidget {
  static Future<String> show(final BuildContext context) async {
    final result = await NavigatorUtility.screen.next(
      context,
      screen: const ScannerDialogRoute(),
    );

    if (result is String) return result;

    return '';
  }


  const ScannerDialogRoute({Key? key}) : super(key: key);

  @override
  State<ScannerDialogRoute> createState() => _ScannerDialogRouteState();
}

class _ScannerDialogRouteState extends State<ScannerDialogRoute> {
  late final size = MediaQuery.of(context).size.width * 2 / 3;

  final scannerController = MobileScannerController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(
        milliseconds: 100,
      ));
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateComponent(
      infoTitle: 'Scan QR Code',
      foregroundColor: Colors.white,
      enableOverlapHeader: true,
      layout: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            allowDuplicates: false,
            onDetect: (barcode, argument) {
              final data = barcode.rawValue;

              if (data?.isEmpty ?? true) return;

              Navigator.pop(context, data);
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
      layoutAction: scannerController.hasTorch ? FloatingActionButton(
        tooltip: 'Toggle Torchlight',
        child: const Icon(Icons.highlight),
        onPressed: () {
          scannerController.toggleTorch();
        },
      ) : null,
    );
  }
}
