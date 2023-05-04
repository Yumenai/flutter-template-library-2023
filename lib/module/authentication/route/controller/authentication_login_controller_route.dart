import 'package:flutter/material.dart';

import '../../../../utility/format_utility.dart';
import '../../../../utility/interface_utility.dart';
import '../../authentication_module.dart';

class AuthenticationLoginControllerRoute {
  final form = _AuthenticateUserForm();

  final void Function() viewSplash;

  AuthenticationLoginControllerRoute({
    required this.viewSplash,
  });

  void signIn(final BuildContext context) async {
    final isClearing = await InterfaceUtility.isFocusClearing(context);

    if (isClearing) return;

    if (form.isNotValid()) return;

    if (!context.mounted) return;

    final isSuccessful = await AuthenticationModule.of(context).repository.user(
      context,
      id: form.idInputController.text,
      password: form.passwordInputController.text,
      onErrorId: form.setErrorId,
      onErrorPassword: form.setErrorPassword,
    );

    form.validate();

    if (!isSuccessful) return;

    viewSplash();
  }
}

class _AuthenticateUserForm {
  final formStateKey = GlobalKey<FormState>();

  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  String errorId = '';
  String errorPassword = '';

  _AuthenticateUserForm();

  bool isValid() {
    reset();
    return formStateKey.currentState?.validate() == true;
  }

  bool isNotValid() {
    return !isValid();
  }

  void validate() {
    formStateKey.currentState?.validate();
  }

  String? validateId(final String? text) {
    return errorId.isEmpty ? _validate(text) : errorId;
  }

  String? validatePassword(final String? text) {
    return errorPassword.isEmpty ? _validate(text) : errorPassword;
  }

  void setErrorId(final String? text) => errorId = text ?? '';

  void setErrorPassword(final String? text) => errorPassword = text ?? '';

  void reset() {
    errorId = '';
    errorPassword = '';
  }

  String? _validate(final String? text) {
    final status = FormatUtility.validate.check(
      text,
      checkContent: true,
    );

    if (status == FormatUtility.validate.invalidEmpty) {
      return 'Please fill in this input fields.';
    }

    return null;
  }
}
