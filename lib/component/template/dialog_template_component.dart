import 'package:flutter/material.dart';

class DialogTemplateComponent extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? message;
  final Color? messageColor;
  final Widget? layout;
  final EdgeInsets? layoutPadding;
  /// Return true to close the dialog
  final MapEntry<String?, bool Function()>? actionPositive;
  final Color? actionPositiveForegroundColor;
  final Color? actionPositiveBackgroundColor;

  final MapEntry<String?, bool Function()>? actionNegative;
  final Color? actionNegativeForegroundColor;
  final Color? actionNegativeBackgroundColor;

  const DialogTemplateComponent({
    Key? key,
    this.title,
    this.titleColor,
    this.message,
    this.messageColor,
    this.layout,
    this.layoutPadding = const EdgeInsets.symmetric(
      horizontal: 24,
    ),
    this.actionPositive,
    this.actionNegative,
    this.actionPositiveForegroundColor,
    this.actionPositiveBackgroundColor,
    this.actionNegativeForegroundColor,
    this.actionNegativeBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? 'Alert',
        style: TextStyle(
          color: titleColor,
        ),
      ),
      content: _contentLayout(),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      actions: _actionLayout(context),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      scrollable: true,
    );
  }

  Widget? _contentLayout() {
    final itemList = <Widget> [];

    if (message?.isNotEmpty == true) {
      itemList.add(Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Text(
          message ?? '',
          style: TextStyle(
            color: messageColor,
          ),
        ),
      ));
    }

    if (layout is Widget) {
      itemList.add(Padding(
        padding: layoutPadding ?? const EdgeInsets.all(0),
        child: layout,
      ));
    }

    if (itemList.isEmpty) return null;

    if (itemList.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: itemList,
      );
    } else {
      return itemList.first;
    }
  }

  List<Widget>? _actionLayout(final BuildContext context) {
    final itemList = <Widget> [];

    if (actionNegative != null) {
      itemList.add(TextButton(
        style: TextButton.styleFrom(
          foregroundColor: actionNegativeForegroundColor,
          backgroundColor: actionNegativeBackgroundColor,
        ),
        child: Text(actionNegative?.key ?? ''),
        onPressed: () {
          final isPressed = actionNegative?.value() == true;

          if (isPressed) {
            Navigator.pop(context, false);
          }
        },
      ));
    }

    if (actionPositive != null) {
      itemList.add(TextButton(
        style: TextButton.styleFrom(
          foregroundColor: actionPositiveForegroundColor,
          backgroundColor: actionPositiveBackgroundColor,
        ),
        child: Text(actionPositive?.key ?? ''),
        onPressed: () {
          final isPressed = actionPositive?.value() == true;

          if (isPressed) {
            Navigator.pop(context, true);
          }
        },
      ));
    }

    if (itemList.isEmpty) return null;

    return itemList;
  }
}
