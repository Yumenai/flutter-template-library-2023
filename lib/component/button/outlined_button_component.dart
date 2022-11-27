import 'package:flutter/material.dart';

class OutlinedButtonComponent extends StatelessWidget {
  final String? title;
  final String? hint;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final OutlinedBorder? shape;
  final VoidCallback onPressed;

  Widget get _infoWidget {
    final itemList = <Widget> [];
    if (prefixIcon is Widget) {
      itemList.add(prefixIcon ?? const SizedBox());
      itemList.add(const SizedBox(
        width: 8,
      ));
    }
    if (title?.isNotEmpty ?? false) {
      itemList.add(Text(title ?? ''));
    }
    if (icon is Widget) {
      itemList.add(icon ?? const SizedBox());
    }
    if (suffixIcon is Widget) {
      itemList.add(const SizedBox(
        width: 8,
      ));
      itemList.add(suffixIcon ?? const SizedBox());
    }

    if (itemList.length == 1) {
      return itemList.first;
    } else if (itemList.length > 1) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: itemList,
      );
    } else {
      return const SizedBox();
    }
  }

  const OutlinedButtonComponent({
    Key? key,
    required this.onPressed,
    this.title,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.margin = const EdgeInsets.all(4),
    this.shape,
    this.hint,
  }) : super(key: key);

  const OutlinedButtonComponent.icon({
    Key? key,
    required this.icon,
    required this.hint,
    required this.onPressed,
    this.margin,
    this.padding =  const EdgeInsets.all(0),
  }) :  title = null,
        prefixIcon = null,
        suffixIcon = null,
        shape =  const CircleBorder(),
        super(key: key);

  const OutlinedButtonComponent.action({
    Key? key,
    required this.title,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.margin = const EdgeInsets.all(4),
  }) :  icon = null,
        hint =  null,
        padding =  const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape =  const StadiumBorder(),
        super(key: key);

  const OutlinedButtonComponent.submit({
    Key? key,
    required this.title,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.margin = const EdgeInsets.all(4),
  }) :  icon = null,
        hint =  null,
        padding =  const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape =  const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonComponent = OutlinedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
        shape: shape,
        padding: padding,
      ),
      child: _infoWidget,
    );

    if (hint?.isNotEmpty ?? false) {
      buttonComponent = Tooltip(
        message: hint,
        child: buttonComponent,
      );
    }

    if (margin == null) return buttonComponent;

    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: buttonComponent,
    );
  }
}
