import 'package:flutter/material.dart';

class MenuItemView extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? color;
  final Widget? prefix;
  final Widget? suffix;
  final void Function()? onTap;

  const MenuItemView({
    Key? key,
    required this.title,
    this.subtitle,
    this.color,
    this.prefix,
    this.suffix,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(title ?? ''),
          subtitle: subtitle?.isNotEmpty == true ? Text(subtitle ?? '') : null,
          textColor: color,
          iconColor: color?.withOpacity(0.6),
          leading: prefix,
          trailing: suffix,
          onTap: onTap,
        ),
        const Divider(
          height: 0.5,
          color: Colors.black12,
        ),
      ],
    );
  }
}
