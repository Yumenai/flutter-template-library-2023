import 'package:flutter/material.dart';

class InterfaceUtility {
  static bool _isFocusClearing = false;

  /// Clear keyboard & prevent double click
  static Future<bool> isFocusClearing(final BuildContext context) async {
    if (_isFocusClearing) return true;

    _isFocusClearing = true;

    // Check whether the keyboard is showing
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 250));
    }

    _isFocusClearing = false;

    return false;
  }

  static Future<bool> isFocusCleared(final BuildContext context) async {
    return !await isFocusClearing(context);
  }

  const InterfaceUtility._();
}
