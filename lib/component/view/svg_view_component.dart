import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgViewComponent extends SvgPicture {
  SvgViewComponent.file(final File file, {
    Key? key,
    final Widget? placeholder,
    final double? width,
    final double? height,
    final BoxFit fit = BoxFit.contain,
    final Color? color,
    final BlendMode colorBlend = BlendMode.srcIn,
  }) : super.file(
    file,
    key: key,
    fit: fit,
    width: width,
    height: height,
    color: color,
    colorBlendMode: colorBlend,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );

  SvgViewComponent.asset(final String assetPath, {
    Key? key,
    final Widget? placeholder,
    final double? width,
    final double? height,
    final BoxFit fit = BoxFit.contain,
    final Color? color,
    final BlendMode colorBlend = BlendMode.srcIn,
  }) : super.asset(
    assetPath,
    key: key,
    fit: fit,
    width: width,
    height: height,
    color: color,
    colorBlendMode: colorBlend,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );

  SvgViewComponent.memory(final Uint8List data, {
    Key? key,
    final Widget? placeholder,
    final double? width,
    final double? height,
    final BoxFit fit = BoxFit.contain,
    final Color? color,
    final BlendMode colorBlend = BlendMode.srcIn,
  }) : super.memory(
    data,
    key: key,
    fit: fit,
    width: width,
    height: height,
    color: color,
    colorBlendMode: colorBlend,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );

  SvgViewComponent.network(final String url, {
    Key? key,
    final Widget? placeholder,
    final double? width,
    final double? height,
    final BoxFit fit = BoxFit.contain,
    final Color? color,
    final BlendMode colorBlend = BlendMode.srcIn,
  }) : super.network(
    url,
    key: key,
    fit: fit,
    width: width,
    height: height,
    color: color,
    colorBlendMode: colorBlend,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );
}

