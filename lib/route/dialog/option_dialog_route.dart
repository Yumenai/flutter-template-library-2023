import 'package:flutter/material.dart';

import '../../component/template/dialog_template_component.dart';
import '../../utility/navigator_utility.dart';

class OptionDialogRoute {
  static Future<int?> show(final BuildContext context, {
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

    final selectedPosition = await NavigatorUtility.dialog.showPopup(
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

  const OptionDialogRoute._();
}
