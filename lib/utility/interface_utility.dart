import 'package:flutter/material.dart';

class InterfaceUtility {
  static Future<void> clearFocus(final BuildContext context) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  const InterfaceUtility._();
}