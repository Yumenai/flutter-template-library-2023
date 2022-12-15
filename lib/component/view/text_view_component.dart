import 'package:flutter/material.dart';

class TextViewComponent extends StatelessWidget {
  final Future<String?> text;

  final TextStyle? style;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextViewComponent.future(this.text, {
    Key? key,
    this.style,
    this.align,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: text,
      builder: (context, asyncSnapshot) {
        return Text(
          asyncSnapshot.data ?? '',
          textAlign: align,
          overflow: overflow,
          maxLines: maxLines,
          style: style,
        );
      },
    );
  }
}
