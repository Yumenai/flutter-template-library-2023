import 'package:flutter/material.dart';

enum IconButtonStyle {
  none,
  elevated,
  outlined,
  gradient,
}

class IconButtonComponent extends StatelessWidget {
  final Widget? icon;
  final String? hint;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final IconButtonStyle style;

  const IconButtonComponent({
    super.key,
    required this.icon,
    required this.hint,
    required this.onPressed,
    this.size = 40,
    this.padding,
    this.margin = const EdgeInsets.all(4),
    this.foregroundColor,
    this.backgroundColor,
    this.style = IconButtonStyle.none,
  });

  const IconButtonComponent.large({
    super.key,
    required this.icon,
    required this.hint,
    required this.onPressed,
    this.padding,
    this.margin = const EdgeInsets.all(4),
    this.foregroundColor,
    this.backgroundColor,
    this.style = IconButtonStyle.none,
  })  : size = 54;

  @override
  Widget build(BuildContext context) {
    final buttonComponent = Tooltip(
      message: hint,
      child: _setupButtonComponent(context),
    );

    if (margin == null) return buttonComponent;

    return Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: buttonComponent,
    );
  }

  Widget _setupButtonComponent(final BuildContext context) {
    switch(style) {
      case IconButtonStyle.none:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            minimumSize: Size.square(size),
            padding: padding,
            shape: const CircleBorder(),
          ),
          child: icon ?? const SizedBox(),
        );
      case IconButtonStyle.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            minimumSize: Size.square(size),
            padding: padding,
            shape: const CircleBorder(),
          ),
          child: icon ?? const SizedBox(),
        );
      case IconButtonStyle.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
            backgroundColor: backgroundColor,
            minimumSize: Size.square(size),
            padding: padding,
            shape: const CircleBorder(),
            side: BorderSide(
              color: foregroundColor ?? Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          child: icon ?? const SizedBox(),
        );
      case IconButtonStyle.gradient:
        final darkBackgroundColor = HSLColor.fromColor(backgroundColor ?? Theme.of(context).colorScheme.primary);
        final lightBackgroundColor = darkBackgroundColor.withLightness((darkBackgroundColor.lightness + 0.2).clamp(0.0, 1.0));

        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Colors.transparent,
            minimumSize: Size.square(size),
            shape: const CircleBorder(),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lightBackgroundColor.toColor(),
                  darkBackgroundColor.toColor(),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            padding: padding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size,
                minWidth: size,
              ),
              child: icon,
            ),
          ),
        );
    }
  }
}
