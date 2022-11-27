import 'package:flutter/material.dart';

class ColorResourceData {
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color onBackground;
  final Color system;
  final Color onSystem;

  const ColorResourceData.dark()
      : primary = const Color(0xFFD0BCFF),
        onPrimary = const Color(0xFF381E72),
        primaryContainer = const Color(0xFF4F378B),
        onPrimaryContainer = const Color(0xFFEADDFF),
        secondary = const Color(0xFFCCC2DC),
        onSecondary = const Color(0xFF332D41),
        secondaryContainer = const Color(0xFF4A4458),
        onSecondaryContainer = const Color(0xFFE8DEF8),
        error = const Color(0xFFF2B8B5),
        onError = const Color(0xFF601410),
        errorContainer = const Color(0xFF8C1D18),
        onErrorContainer = const Color(0xFFF2B8B5),
        surface = const Color(0xFF1C1B1F),
        onSurface = const Color(0xFFE6E1E5),
        background = const Color(0xFFFFFBFE),
        onBackground = const Color(0xFF1C1B1F),
        system = const Color(0xFF1C1B1F),
        onSystem = const Color(0xFFE6E1E5);

  const ColorResourceData.light()
      : primary = const Color(0xFF6750A4),
        onPrimary = const Color(0xFFFFFFFF),
        primaryContainer = const Color(0xFFEADDFF),
        onPrimaryContainer = const Color(0xFF21005D),
        secondary = const Color(0xFF625B71),
        onSecondary = const Color(0xFFFFFFFF),
        secondaryContainer = const Color(0xFFE8DEF8),
        onSecondaryContainer = const Color(0xFF1D192B),
        error = const Color(0xFFB3261E),
        onError = const Color(0xFFFFFFFF),
        errorContainer = const Color(0xFFF9DEDC),
        onErrorContainer = const Color(0xFF410E0B),
        surface = const Color(0xFFFFFBFE),
        onSurface = const Color(0xFF1C1B1F),
        background = const Color(0xFFFFFBFE),
        onBackground = const Color(0xFF1C1B1F),
        system = const Color(0xFFFFFBFE),
        onSystem = const Color(0xFF1C1B1F);
}
