import 'package:flutter/material.dart';

import '../../component/template/dialog_template_component.dart';
import '../../utility/navigator_utility.dart';

enum AlertDialogStyle {
  alert,
  warning,
}

class AlertDialogRoute {
  static Future<bool?> show(final BuildContext context, {
    final String? title,
    final String? message,
    final void Function()? onPressedPositive,
    final bool enablePositiveClosure = true,
    final AlertDialogStyle style = AlertDialogStyle.alert,
  }) async {
    Color? color;
    Color? onColor;

    if (style == AlertDialogStyle.warning) {
      color = Theme.of(context).colorScheme.error;
      onColor = Theme.of(context).colorScheme.onError;
    }

    return await NavigatorUtility.dialog.showPopup(
      context,
      widget: DialogTemplateComponent(
        title: title ?? 'Alert',
        titleColor: color,
        message: message,
        messageColor: color,
        actionPositive: MapEntry('Okay', () {
          onPressedPositive?.call();

          return enablePositiveClosure;
        }),
        actionPositiveBackgroundColor: color,
        actionPositiveForegroundColor: onColor,
      ),
    ) == true;
  }

  static Future<bool?> showConfirm(final BuildContext context, {
    final String? title,
    final String? message,
    final String? positiveTitle,
    final String? negativeTitle,
    final bool enablePositiveClosure = true,
    final bool enableNegativeClosure = true,
    final void Function()? onPressedPositive,
    final void Function()? onPressedNegative,
    final AlertDialogStyle style = AlertDialogStyle.alert,
  }) async {
    Color? color;
    Color? onColor;

    if (style == AlertDialogStyle.warning) {
      color = Theme.of(context).colorScheme.error;
      onColor = Theme.of(context).colorScheme.onError;
    }

    return await NavigatorUtility.dialog.showPopup(
      context,
      widget: DialogTemplateComponent(
        title: title ?? 'Confirm',
        titleColor: color,
        message: message,
        messageColor: color,
        actionPositive: MapEntry('Yes, Confirm', () {
          onPressedPositive?.call();

          return enablePositiveClosure;
        }),
        actionPositiveBackgroundColor: color,
        actionPositiveForegroundColor: onColor,
        actionNegative: MapEntry('No, Cancel', () {
          onPressedNegative?.call();

          return enableNegativeClosure;
        }),
      ),
    ) == true;
  }

  static Future<bool?> showLoading(final BuildContext context, {
    final String? title,
    final String? message,
    final bool isDismissible = false,
  }) async {
    return await NavigatorUtility.dialog.showPopup(
      context,
      dismissible: isDismissible,
      widget: DialogTemplateComponent(
        title: title ?? 'Loading...',
        message: message,
        layout: const LinearProgressIndicator(),
        layoutPadding: const EdgeInsets.only(
          top: 12,
          left: 24,
          right: 24,
          bottom: 24,
        ),
      ),
    ) == true;
  }

  const AlertDialogRoute._();
}
