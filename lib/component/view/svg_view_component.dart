import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgViewComponent extends SvgPicture {
  SvgViewComponent.file(final File file, {
    super.key,
    final Widget? placeholder,
    super.width,
    super.height,
    super.fit = BoxFit.contain,
    super.color,
    super.colorBlendMode = BlendMode.srcIn,
  }) : super.file(
    file,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );

  SvgViewComponent.asset(final String assetPath, {
    super.key,
    final Widget? placeholder,
    super.width,
    super.height,
    super.fit = BoxFit.contain,
    super.color,
    super.colorBlendMode = BlendMode.srcIn,
  }) : super.asset(
    assetPath,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );

  SvgViewComponent.memory(final Uint8List data, {
    super.key,
    final Widget? placeholder,
    super.width,
    super.height,
    super.fit = BoxFit.contain,
    super.color,
    super.colorBlendMode = BlendMode.srcIn,
  }) : super.memory(
    data,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );

  SvgViewComponent.network(final String url, {
    super.key,
    final Widget? placeholder,
    super.width,
    super.height,
    super.fit = BoxFit.contain,
    super.color,
    super.colorBlendMode = BlendMode.srcIn,
  }) : super.network(
    url,
    placeholderBuilder: placeholder == null ? null : (context) {
      return placeholder;
    },
  );
}

