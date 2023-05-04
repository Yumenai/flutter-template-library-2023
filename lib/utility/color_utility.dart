import 'package:flutter/material.dart';

class ColorUtility {
  static Color getOnColor(final Color color) {
    if (color.computeLuminance() > 0.179) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static Color? getColor(final int? value) {
    if (value == null) return null;

    final color = Color.fromRGBO(
      (value & 0xFF0000) >> 16,
      (value & 0xFF00) >> 8,
      value & 0xFF,
      ((value & 0xFF000000) >> 24) / 255.0,
    );

    return color;
  }

  const ColorUtility._();
}
