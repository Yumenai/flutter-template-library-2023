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
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.code39;

  const CodeViewComponent.code93({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.code93;

  const CodeViewComponent.code128({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.code128;

  const CodeViewComponent.gs1128({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.gs128;

  const CodeViewComponent.itf({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.itf;

  const CodeViewComponent.itf14({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.itf14;

  const CodeViewComponent.itf16({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.itf16;

  const CodeViewComponent.ean13({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.ean13;

  const CodeViewComponent.ean8({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.ean8;

  const CodeViewComponent.ean2({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.ean2;

  const CodeViewComponent.isbn({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.isbn;

  const CodeViewComponent.upcA({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.upcA;

  const CodeViewComponent.upcE({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.upcE;

  const CodeViewComponent.telepen({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.telepen;

  const CodeViewComponent.codabar({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.codabar;

  const CodeViewComponent.rm4Scc({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.rm4Scc;

  const CodeViewComponent.pdf417({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.pdf417;

  /// 2D Code
  const CodeViewComponent.qrCode({
    super.key,
    required this.data,
    final double? size,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.qrCode;

  const CodeViewComponent.dataMatrix({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.dataMatrix;

  const CodeViewComponent.aztec({
    super.key,
    required this.data,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  })  : type = CodeViewType.aztec;

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
