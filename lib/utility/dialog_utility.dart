import 'dart:async';

import 'package:flutter/material.dart';

import '../view/template/dialog_template_view.dart';

class DialogUtility {
  static Future<bool> showAlert(final BuildContext context, {
    final String? title,
    final String? message,
    final Widget? layout,
    final EdgeInsets? layoutPadding,
    final String? positiveTitle,
    final Color? color,
    final Color? onColor,
    final bool enableDismissal = true,
  }) async {
    return await _showPopup(
      context,
      widget: DialogTemplateView(
        title: title ?? 'Alert',
        titleColor: color,
        message: message,
        messageColor: color,
        layout: layout,
        layoutPadding: layoutPadding,
        actionPositiveTitle: positiveTitle ?? 'Dismiss',
        actionPositiveBackgroundColor: color,
        actionPositiveForegroundColor: onColor,
        enablePositiveDismissal: enableDismissal,
        enablePositiveAction: true,
      ),
    ) == true;
  }

  static Future<bool> showConfirm(final BuildContext context, {
    final String? title,
    final String? message,
    final Widget? layout,
    final EdgeInsets? layoutPadding,
    final String? positiveTitle,
    final String? negativeTitle,
    final Color? color,
    final Color? onColor,
    final bool enableDismissalPositive = true,
    final bool enableDismissalNegative = true,
    final void Function()? onPressedPositive,
    final void Function()? onPressedNegative,
  }) async {
    return await _showPopup(
      context,
      widget: DialogTemplateView(
        title: title ?? 'Confirm',
        titleColor: color,
        message: message,
        messageColor: color,
        layout: layout,
        layoutPadding: layoutPadding,
        actionPositiveTitle: positiveTitle ?? 'Yes, Confirm',
        actionPositiveBackgroundColor: color ?? Theme.of(context).colorScheme.primary,
        actionPositiveForegroundColor: onColor ?? Theme.of(context).colorScheme.onPrimary,
        actionNegativeTitle: negativeTitle ?? 'No, Cancel',
        enablePositiveAction: true,
        enableNegativeAction: true,
        enablePositiveDismissal: enableDismissalPositive,
        enableNegativeDismissal: enableDismissalNegative,
        onTapActionPositive: onPressedPositive,
        onTapActionNegative: onPressedNegative,
      ),
    ) == true;
  }

  static Future<int?> showOptionSelector(final BuildContext context, {
    required final String? title,
    final String? message,
    final int? selectedOptionPosition,
    required final List<String?> optionList,
  }) async {
    final itemList = <Widget> [];

    for (int i = 0; i < optionList.length; i++) {
      itemList.add(RadioListTile(
        value: selectedOptionPosition == i,
        groupValue: true,
        title: Text(optionList[i] ?? ''),
        onChanged: (_) {
          Navigator.pop(context, i);
        },
      ));
    }

    final selectedPosition = await _showPopup(
      context,
      widget: DialogTemplateView(
        title: title ?? '',
        message: message,
        layoutPadding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        layout: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: itemList,
        ),
      ),
    );

    if (selectedPosition is int) return selectedPosition;

    return null;
  }

  static Future<bool> showLoading(final BuildContext context, {
    final String? title,
    final String? message,
    final bool enableDismissal = false,
  }) async {
    return await _showPopup(
      context,
      dismissible: enableDismissal,
      widget: DialogTemplateView(
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

  static void showMessage(final BuildContext context, {
    required final String? message,
    final Duration duration = const Duration(
      milliseconds: 750,
    ),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ''),
      duration: duration,
    ));
  }





  /// [showDateSelector] Info
  /// [selectedDate] This highlights the selected date
  /// [currentDate] This outlined the preset/default date
  /// [startDate] This determine first available date for user to pick from
  /// [lastDate] This determine last available date for user to pick from
  /// [lastDate] This determine last available date for user to pick from
  static Future<DateTime?> showDateSelector(final BuildContext context, {
    final String? title,
    final DateTime? selectedDate,
    final DateTime? currentDate,
    final DateTime? firstDate,
    final DateTime? lastDate,
  }) {
    return showDatePicker(
      context: context,
      helpText: title,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime(2150),
      currentDate: currentDate,
    );
  }

  /// [showTimerSelector] Info
  /// [selectedTime] This highlights the selected time
  static Future<TimeOfDay?> showTimerSelector(final BuildContext context, {
    final TimeOfDay? selectedTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  }


  static Future<dynamic> _showPopup(final BuildContext context, {
    required final Widget widget,
    final bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        if (!dismissible) {
          return WillPopScope(
            child: widget,
            onWillPop: () async {
              return false;
            },
          );
        } else {
          return widget;
        }
      },
    );
  }
}