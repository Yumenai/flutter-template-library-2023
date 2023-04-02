import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../component/template/dialog_template_component.dart';
import 'file_utility.dart';

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
      widget: DialogTemplateComponent(
        title: title ?? 'Alert',
        titleColor: color,
        message: message,
        messageColor: color,
        layout: layout,
        layoutPadding: layoutPadding,
        actionPositiveTitle: positiveTitle ?? 'Dismiss',
        actionPositiveBackgroundColor: color,
        actionPositiveForegroundColor: onColor,
        enableDismissalPositive: enableDismissal,
        enableActionPositive: true,
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
      widget: DialogTemplateComponent(
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
        enableActionPositive: true,
        enableActionNegative: true,
        enableDismissalPositive: enableDismissalPositive,
        enableDismissalNegative: enableDismissalNegative,
        onTapActionPositive: onPressedPositive,
        onTapActionNegative: onPressedNegative,
      ),
    ) == true;
  }

  static Future<bool> showLoading(final BuildContext context, {
    final String? title,
    final String? message,
    final bool enableDismissal = false,
  }) async {
    return await _showPopup(
      context,
      dismissible: enableDismissal,
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





  /// [selectDate] Info
  /// [selectedDate] This highlights the selected date
  /// [currentDate] This outlined the preset/default date
  /// [startDate] This determine first available date for user to pick from
  /// [lastDate] This determine last available date for user to pick from
  /// [lastDate] This determine last available date for user to pick from
  static Future<DateTime?> selectDate(final BuildContext context, {
    final DateTime? selectedDate,
    final DateTime? currentDate,
    final DateTime? firstDate,
    final DateTime? lastDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1950),
      lastDate: lastDate ?? DateTime(2150),
      currentDate: currentDate,
    );
  }

  /// [selectTime] Info
  /// [selectedTime] This highlights the selected time
  static Future<TimeOfDay?> selectTime(final BuildContext context, {
    final TimeOfDay? selectedTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  }

  static Future<int?> selectOptionList(final BuildContext context, {
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
      widget: DialogTemplateComponent(
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

  static Future<File?> selectImage(final BuildContext context) async {
    final selectedOptionPosition = await selectOptionList(
      context,
      title: 'Select Image',
      optionList: [
        'Camera',
        'Gallery',
      ],
    );

    if (selectedOptionPosition == 0) {
      return FileUtility.captureImage();
    } else if (selectedOptionPosition == 1) {
      return FileUtility.selectImage();
    } else {
      return null;
    }
  }

  static Future<File?> selectFile(final BuildContext context, {
    final String? title,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: title,
    );

    if (result == null) return null;

    if (result.files.isEmpty) return null;

    return File(result.files.first.path ?? '');
  }

  static Future<List<File>> selectFileList(final BuildContext context, {
    final String? title,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: true,
    );

    if (result == null) return [];

    final fileList = <File> [];

    for (final file in result.files) {
      if (file.path?.isNotEmpty ?? false) {
        fileList.add(File(file.path ?? ''));
      }
    }

    return fileList;
  }



  // TODO integrate the option to change dialog from popup to bottom sheet
  // static Future<dynamic> showSheet(final BuildContext context, {
  //   final List<Widget>? children,
  //   final bool enableScrollable = false,
  // }) async {
  //   return showModalBottomSheet(
  //     context: context,
  //     clipBehavior: Clip.antiAlias,
  //     isScrollControlled: enableScrollable,
  //     builder: (context) {
  //       if (enableScrollable) {
  //         return DraggableScrollableSheet(
  //           snap: true,
  //           expand: false,
  //           maxChildSize: 0.85,
  //           minChildSize: 0.5,
  //           builder: (context, scrollController) {
  //             return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.all(Radius.circular(99)),
  //                   ),
  //                   margin: const EdgeInsets.all(12),
  //                   height: 10,
  //                   width: 100,
  //                 ),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     controller: scrollController,
  //                     itemCount: 100,
  //                     itemBuilder: (context, index) => ListTile(title: Text('Test $index'), onTap: () {},),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       } else {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.grey,
  //                 borderRadius: BorderRadius.all(Radius.circular(99)),
  //               ),
  //               margin: const EdgeInsets.all(12),
  //               height: 10,
  //               width: 100,
  //             ),
  //             ...?children,
  //           ],
  //         );
  //       }
  //     },
  //   );
  // }
  //
  // static Future<dynamic> showSheetScreen(final BuildContext context, {
  //   final List<Widget>? children,
  //   final bool enableScrollable = false,
  // }) async {
  //   final result = showBottomSheet(
  //     context: context,
  //     clipBehavior: Clip.antiAlias,
  //     builder: (context) {
  //       if (enableScrollable) {
  //         return DraggableScrollableSheet(
  //           snap: true,
  //           expand: false,
  //           maxChildSize: 0.7,
  //           builder: (context, scrollController) {
  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.all(Radius.circular(99)),
  //                   ),
  //                   margin: const EdgeInsets.all(12),
  //                   height: 10,
  //                   width: 100,
  //                 ),
  //                 if ((children?.length ?? 0) > 20)
  //                   Expanded(
  //                     child: ListView.builder(
  //                       controller: scrollController,
  //                       itemCount: children?.length ?? 0,
  //                       itemBuilder: (context, index) => children?[index] ?? const SizedBox(),
  //                     ),
  //                   )
  //                 else
  //                   Expanded(
  //                     child: ListView(
  //                       controller: scrollController,
  //                       children: children ?? [],
  //                     ),
  //                   ),
  //               ],
  //             );
  //           },
  //         );
  //       } else {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.grey,
  //                 borderRadius: BorderRadius.all(Radius.circular(99)),
  //               ),
  //               margin: const EdgeInsets.all(12),
  //               height: 10,
  //               width: 100,
  //             ),
  //             ...?children,
  //           ],
  //         );
  //       }
  //     },
  //   );
  //
  //   return result.closed;
  // }























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