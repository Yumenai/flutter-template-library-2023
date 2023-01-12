import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CodeViewType {
  /// 1D
  code39,
  code93,
  code128,
  gs128,
  itf,
  itf14,
  itf16,
  ean13,
  ean8,
  ean2,
  isbn,
  upcA,
  upcE,
  telepen,
  codabar,
  rm4Scc,
  pdf417,

  /// 2D
  qrCode,
  dataMatrix,
  aztec,
}

class CodeViewComponent extends StatelessWidget {
  final String data;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final CodeViewType type;

  /// 1D Code
  const CodeViewComponent.code39({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.code39,
        super(key: key);

  const CodeViewComponent.code93({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.code93,
        super(key: key);

  const CodeViewComponent.code128({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.code128,
        super(key: key);

  const CodeViewComponent.gs1128({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.gs128,
        super(key: key);

  const CodeViewComponent.itf({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.itf,
        super(key: key);

  const CodeViewComponent.itf14({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.itf14,
        super(key: key);

  const CodeViewComponent.itf16({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.itf16,
        super(key: key);

  const CodeViewComponent.ean13({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.ean13,
        super(key: key);

  const CodeViewComponent.ean8({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.ean8,
        super(key: key);

  const CodeViewComponent.ean2({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.ean2,
        super(key: key);

  const CodeViewComponent.isbn({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.isbn,
        super(key: key);

  const CodeViewComponent.upcA({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.upcA,
        super(key: key);

  const CodeViewComponent.upcE({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.upcE,
        super(key: key);

  const CodeViewComponent.telepen({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.telepen,
        super(key: key);

  const CodeViewComponent.codabar({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.codabar,
        super(key: key);

  const CodeViewComponent.rm4Scc({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.rm4Scc,
        super(key: key);

  const CodeViewComponent.pdf417({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.pdf417,
        super(key: key);

  /// 2D Code
  const CodeViewComponent.qrCode({
    Key? key,
    required this.data,
    final double? size,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.qrCode,
        super(key: key);

  const CodeViewComponent.dataMatrix({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.dataMatrix,
        super(key: key);

  const CodeViewComponent.aztec({
    Key? key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.aztec,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final codeSvg = rawCode.toSvg(
      data,
      color: foregroundColor?.value ?? 0x000000,
    );

    final Widget codeComponent;

    if (is2D) {
      codeComponent = AspectRatio(
        aspectRatio: 1,
        child: SvgPicture.string(
          codeSvg,
          fit: BoxFit.cover,
        ),
      );
    } else if (type == CodeViewType.pdf417) {
      codeComponent = AspectRatio(
        aspectRatio: 3,
        child: SvgPicture.string(
          codeSvg,
          fit: BoxFit.cover,
        ),
      );
    } else {
      codeComponent = AspectRatio(
        aspectRatio: 2.5,
        child: SvgPicture.string(
          codeSvg,
          fit: BoxFit.cover,
        ),
      );
    }

    return Material(
      color: backgroundColor ?? Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: codeComponent,
      ),
    );
  }

  Barcode get rawCode {
    switch (type) {
      case CodeViewType.code39:
        return Barcode.code39();
      case CodeViewType.code93:
        return Barcode.code93();
      case CodeViewType.code128:
        return Barcode.code128();
      case CodeViewType.gs128:
        return Barcode.gs128();
      case CodeViewType.itf:
        return Barcode.itf14();
      case CodeViewType.itf14:
        return Barcode.itf16();
      case CodeViewType.itf16:
        return Barcode.itf16();
      case CodeViewType.ean13:
        return Barcode.ean13();
      case CodeViewType.ean8:
        return Barcode.ean8();
      case CodeViewType.ean2:
        return Barcode.ean2();
      case CodeViewType.isbn:
        return Barcode.isbn();
      case CodeViewType.upcA:
        return Barcode.upcA();
      case CodeViewType.upcE:
        return Barcode.upcE();
      case CodeViewType.telepen:
        return Barcode.telepen();
      case CodeViewType.codabar:
        return Barcode.codabar();
      case CodeViewType.rm4Scc:
        return Barcode.rm4scc();
      case CodeViewType.pdf417:
        return Barcode.pdf417(
          moduleHeight: 5.7,
        );
      case CodeViewType.qrCode:
        return Barcode.qrCode();
      case CodeViewType.dataMatrix:
        return Barcode.dataMatrix();
      case CodeViewType.aztec:
        return Barcode.aztec();
    }
  }

  bool get is2D {
    return type == CodeViewType.qrCode ||
        type == CodeViewType.dataMatrix ||
        type == CodeViewType.aztec;
  }
}
