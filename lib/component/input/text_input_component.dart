import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextInputStyle {
  line,
  fill,
  outline,
}

InputDecoration _inputDecoration({
  required final String? label,
  required final String? hint,
  required final Color? backgroundColor,
  required final String? prefixText,
  required final Widget? prefixIcon,
  required final String? suffixText,
  required final Widget? suffixIcon,
  required final bool enablePaddingVertical,
  required final bool enablePrefixIconConstraint,
  required final bool enableSuffixIconConstraint,
  required final Brightness brightness,
  required final TextInputStyle style,
}) {
  final EdgeInsets padding;
  final InputBorder inputBorder;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color? backgroundColorComponent;

  switch(style) {
    case TextInputStyle.line:
      padding = EdgeInsets.zero;
      inputBorder = const UnderlineInputBorder();
      floatingLabelBehavior = FloatingLabelBehavior.auto;
      backgroundColorComponent = backgroundColor;
      break;
    case TextInputStyle.fill:
      padding = enablePaddingVertical ? const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ) : const EdgeInsets.symmetric(
        horizontal: 12,
      );
      inputBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide.none,
      );
      floatingLabelBehavior = FloatingLabelBehavior.never;
      backgroundColorComponent = backgroundColor ?? (brightness == Brightness.light ? const Color(0xFFEEEEEE) : const Color(0x61000000));
      break;
    case TextInputStyle.outline:
      padding = enablePaddingVertical ? const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ) : const EdgeInsets.symmetric(
        horizontal: 12,
      );
      inputBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      );
      floatingLabelBehavior = FloatingLabelBehavior.auto;
      backgroundColorComponent = backgroundColor;
      break;
  }

  return InputDecoration(
    filled: backgroundColorComponent is Color,
    fillColor: backgroundColorComponent,
    labelText: label,
    hintText: hint,
    border: inputBorder,
    contentPadding: padding,
    floatingLabelBehavior: floatingLabelBehavior,
    prefixIcon: prefixIcon == null ? null : enablePrefixIconConstraint ? prefixIcon : UnconstrainedBox(
      child: prefixIcon,
    ),
    prefixText: prefixText,
    suffixText: suffixText,
    suffixIcon: suffixIcon == null ? null : enableSuffixIconConstraint ? suffixIcon : UnconstrainedBox(
      child: suffixIcon,
    ),
    alignLabelWithHint: true,
    errorMaxLines: 3,
  );
}

class TextInputComponent extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;

  final String? prefixText;
  final Widget? prefixIcon;
  final String? suffixText;
  final Widget? suffixIcon;

  final int maxLine;
  final int minLine;

  final String? regexFormat;

  final Color? backgroundColor;

  final bool enableSpacing;
  final bool enableViewOnly;
  final bool enableObscurity;
  final bool enableAutocorrect;
  final bool enablePrefixIconConstraint;
  final bool enableSuffixIconConstraint;

  final void Function(String?)? onEdit;
  final void Function(String?)? onSubmit;
  final String? Function(String?)? onValidate;

  final TextCapitalization capitalization;
  final TextInputAction action;
  final TextInputStyle style;
  final TextInputType type;

  const TextInputComponent({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.maxLine = 1,
    this.minLine = 1,

    this.regexFormat,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enableObscurity = false,
    this.enableAutocorrect = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onEdit,
    this.onSubmit,
    this.onValidate,

    this.capitalization = TextCapitalization.none,
    this.action = TextInputAction.next,
    this.style = TextInputStyle.outline,
    this.type = TextInputType.text,
  })  : super(key: key);

  const TextInputComponent.name({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.maxLine = 1,
    this.minLine = 1,

    this.regexFormat,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onEdit,
    this.onSubmit,
    this.onValidate,

    this.action = TextInputAction.next,
    this.style = TextInputStyle.outline,
  })  : capitalization = TextCapitalization.words,
        enableObscurity = false,
        enableAutocorrect = false,
        type = TextInputType.name,
        super(key: key);

  const TextInputComponent.field({
    Key? key,
    this.controller,
    this.label,
    this.hint,

    this.maxLine = 6,
    this.minLine = 3,

    this.regexFormat,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onEdit,
    this.onValidate,

    this.action = TextInputAction.newline,
    this.style = TextInputStyle.outline,
  })  : capitalization = TextCapitalization.words,
        prefixIcon = null,
        prefixText = null,
        suffixIcon = null,
        suffixText = null,
        enableObscurity = false,
        enableAutocorrect = false,
        onSubmit = null,
        type = TextInputType.name,
        super(key: key);

  const TextInputComponent.email({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onEdit,
    this.onSubmit,
    this.onValidate,

    this.action = TextInputAction.next,
    this.style = TextInputStyle.outline,
  })  : regexFormat = null,
        maxLine = 1,
        minLine = 1,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableAutocorrect = false,
        type = TextInputType.emailAddress,
        super(key: key);

  const TextInputComponent.phone({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onEdit,
    this.onSubmit,
    this.onValidate,

    this.action = TextInputAction.next,
    this.style = TextInputStyle.outline,
  })  : regexFormat = null,
        maxLine = 1,
        minLine = 1,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableAutocorrect = false,
        type = TextInputType.phone,
        super(key: key);

  const TextInputComponent.number({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onEdit,
    this.onSubmit,
    this.onValidate,

    this.action = TextInputAction.next,
    this.style = TextInputStyle.outline,
  })  : regexFormat = r'\d',
        maxLine = 1,
        minLine = 1,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableAutocorrect = false,
        type = TextInputType.number,
        super(key: key);

  const TextInputComponent.decimal({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.backgroundColor,

    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    final int? integerSize,
    final int? fractionSize,
    final bool enableDigitSign = true,

    this.onEdit,
    this.onSubmit,
    this.onValidate,

    this.action = TextInputAction.next,
    this.style = TextInputStyle.outline,
  })  : regexFormat = '^${enableDigitSign ? '[-,+]?' : ''}\\d${integerSize is int ? '{0,$integerSize}' : '*'}(\\.\\d${fractionSize is int ? '{0,$fractionSize}' : '*'})?',
        maxLine = 1,
        minLine = 1,
        capitalization = TextCapitalization.none,
        enableObscurity = false,
        enableAutocorrect = false,
        type = const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputComponent = TextFormField(
      controller: controller,
      readOnly: enableViewOnly,
      obscureText: enableObscurity,
      enableInteractiveSelection: !enableViewOnly,
      decoration: _inputDecoration(
        label: label,
        hint: hint,
        backgroundColor: backgroundColor,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        enablePaddingVertical: maxLine > 1,
        enablePrefixIconConstraint: enablePrefixIconConstraint,
        enableSuffixIconConstraint: enableSuffixIconConstraint,
        brightness: Theme.of(context).brightness,
        style: style,
      ),
      maxLines: maxLine,
      minLines: minLine,
      inputFormatters: regexFormat?.isNotEmpty == true ? [
        FilteringTextInputFormatter.allow(RegExp(regexFormat ?? ''))
      ] : null,
      textInputAction: action,
      textCapitalization: capitalization,
      keyboardType: type,
      onChanged: onEdit,
      onFieldSubmitted: onSubmit,
      validator: onValidate,
    );

    if (enableSpacing) {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
        ),
        child: inputComponent,
      );
    }

    return inputComponent;
  }
}

class ActionTextInputComponent extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? actionSelect;
  final String? actionClear;

  final String? prefixText;
  final Widget? prefixIcon;

  final Color? backgroundColor;

  final bool enableViewOnly;

  final void Function(String?)? onEdit;
  final void Function(String?)? onSubmit;
  final String? Function(String?)? onValidate;
  final FutureOr<void>? Function(bool)? onSelect;

  final TextInputStyle style;

  const ActionTextInputComponent({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.actionSelect,
    this.actionClear,
    this.prefixIcon,
    this.prefixText,
    this.backgroundColor,
    this.enableViewOnly = true,
    this.onEdit,
    this.onSubmit,
    this.onValidate,
    this.onSelect,
    this.style = TextInputStyle.outline,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionButtonStyle = _actionButtonStyle(context);

    return TextInputComponent(
      controller: controller,
      label: label,
      hint: hint,
      prefixIcon: prefixIcon,
      prefixText: prefixText,
      suffixIcon: AnimatedBuilder(
        animation: controller ?? TextEditingController(),
        builder: (context, child) {
          final isSelected = controller?.text.isNotEmpty == true;

          return ElevatedButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              await onSelect?.call(isSelected);
            },
            style: actionButtonStyle,
            child: isSelected ? Text(actionClear ?? 'Clear') : Text(actionSelect ?? 'Select'),
          );
        },
      ),
      backgroundColor: backgroundColor,
      enableViewOnly: enableViewOnly,
      enableSuffixIconConstraint: style != TextInputStyle.line,
      onEdit: onEdit,
      onSubmit: onSubmit,
      onValidate: onValidate,
      style: style,
    );
  }

  ButtonStyle _actionButtonStyle(final BuildContext context) {
    if (style == TextInputStyle.line) {
      return ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    } else {
      return ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(12),
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    }
  }
}

class SecureTextInputComponent extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? actionSelect;
  final String? actionClear;

  final String? prefixText;
  final Widget? prefixIcon;

  final Color? backgroundColor;

  final bool enableSpacing;
  final bool enableViewOnly;

  final void Function(String?)? onEdit;
  final void Function(String?)? onSubmit;
  final String? Function(String?)? onValidate;

  final TextInputStyle style;

  const SecureTextInputComponent({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.actionSelect,
    this.actionClear,
    this.prefixIcon,
    this.prefixText,
    this.backgroundColor,
    this.enableSpacing = true,
    this.enableViewOnly = false,
    this.onEdit,
    this.onSubmit,
    this.onValidate,
    this.style = TextInputStyle.outline,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHidden = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextInputComponent(
          controller: controller,
          label: label,
          hint: hint,
          prefixIcon: prefixIcon,
          prefixText: prefixText,
          enableObscurity: isHidden,
          suffixIcon: IconButton(
            icon: isHidden ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
            onPressed: () {
              isHidden = !isHidden;
              setState(() {});
            },
          ),
          backgroundColor: backgroundColor,
          enableViewOnly: enableViewOnly,
          enableSuffixIconConstraint: style != TextInputStyle.line,
          onEdit: onEdit,
          onSubmit: onSubmit,
          onValidate: onValidate,
          style: style,
        );
      },
    );
  }
}

class OptionTextInputComponent extends StatelessWidget {
  final String? label;
  final String? hint;
  final int? initialValue;
  final List<String> optionList;

  final String? prefixText;
  final Widget? prefixIcon;
  final String? suffixText;
  final Widget? suffixIcon;

  final Color? backgroundColor;

  final bool enableSpacing;
  final bool enableViewOnly;
  final bool enableObscurity;
  final bool enablePrefixIconConstraint;
  final bool enableSuffixIconConstraint;

  final void Function(int)? onSelect;
  final String? Function(int?)? onValidate;

  final TextInputStyle style;

  const OptionTextInputComponent({
    Key? key,
    this.label,
    this.hint,
    this.initialValue,
    this.optionList = const [],

    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,

    this.backgroundColor,

    this.enableSpacing = false,
    this.enableViewOnly = false,
    this.enableObscurity = false,
    this.enablePrefixIconConstraint = false,
    this.enableSuffixIconConstraint = false,

    this.onSelect,
    this.onValidate,

    this.style = TextInputStyle.outline,
  }) : super(key: key);

  List<DropdownMenuItem<int>> get optionItemList {
    final itemList = <DropdownMenuItem<int>> [];

    for (int i = 0; i < optionList.length; i++) {
      itemList.add(
        DropdownMenuItem<int>(
          value: i,
          child: Text(optionList[i]),
        ),
      );
    }

    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: initialValue,
      items: optionItemList,
      decoration: _inputDecoration(
        label: label,
        hint: hint,
        backgroundColor: backgroundColor,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        enablePaddingVertical: false,
        enablePrefixIconConstraint: enablePrefixIconConstraint,
        enableSuffixIconConstraint: enableSuffixIconConstraint,
        brightness: Theme.of(context).brightness,
        style: style,
      ),
      onChanged: (indexPosition) {
        if (indexPosition is int) {
          onSelect?.call(indexPosition);
        }
      },
      validator: onValidate,
    );
  }
}
