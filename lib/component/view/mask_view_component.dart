import 'package:flutter/material.dart';

enum MaskViewStyle {
  fadeTop,
  fadeBottom,
}

class MaskViewComponent extends StatelessWidget {
  final Widget child;
  final MaskViewStyle style;

  const MaskViewComponent.fadeTop({
    super.key,
    required this.child,
  }) :  style = MaskViewStyle.fadeTop;

  const MaskViewComponent.fadeBottom({
    super.key,
    required this.child,
  }) :  style = MaskViewStyle.fadeBottom;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        switch(style) {
          case MaskViewStyle.fadeTop:
            return const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, 50));
          case MaskViewStyle.fadeBottom:
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, rect.height - 50, rect.width, rect.height));
        }
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
