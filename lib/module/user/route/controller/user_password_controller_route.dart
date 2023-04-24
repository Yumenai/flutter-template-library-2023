import 'package:flutter/material.dart';

import '../../../../utility/dialog_utility.dart';
import '../../../../utility/format_utility.dart';
import '../../../../utility/interface_utility.dart';
import '../../user_master.dart';

class UserPasswordControllerRoute {
  final form = _UserPasswordForm();

  UserPasswordControllerRoute();

  void update(final BuildContext context) async {
    final isClearing = await InterfaceUtility.isFocusClearing(context);

    if (isClearing) return;

    if (form.isNotValid()) return;

    if (!context.mounted) return;

    final isSuccess = await UserMaster.of(context).repository.updatePassword(
      context,
      currentPassword: form.currentPasswordInputController.text,
      replacePassword: form.replacePasswordInputController.text,
    );

    if (!isSuccess) return;

    if (!context.mounted) return;

    await DialogUtility.showAlert(
      context,
      title: 'Success',
      message: 'Password Updated!',
    );

    if (!context.mounted) return;

    Navigator.pop(context);
  }
}

class _UserPasswordForm {
  final formStateKey = GlobalKey<FormState>();

  final currentPasswordInputController = TextEditingController();
  final replacePasswordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  String errorCurrentPassword = '';
  String errorReplacePassword = '';
  String errorConfirmPassword = '';

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

  String? validateCurrentPassword(final String? text) {
    return errorCurrentPassword.isEmpty ? _validate(text) : errorCurrentPassword;
  }

  String? validateReplacePassword(final String? text) {
    if (replacePasswordInputController.text != confirmPasswordInputController.text) {
      return 'Please ensure the password matched the confirm password input fields';
    }

    return errorReplacePassword.isEmpty ? _validate(text) : errorReplacePassword;
  }

  String? validateConfirmPassword(final String? text) {
    if (replacePasswordInputController.text != confirmPasswordInputController.text) {
      return 'Please ensure the confirm password matched the password input fields';
    }

    return errorConfirmPassword.isEmpty ? _validate(text) : errorConfirmPassword;
  }

  void setErrorCurrentPassword(final String? text) => errorCurrentPassword = text ?? '';

  void setErrorReplacePassword(final String? text) => errorReplacePassword = text ?? '';

  void setErrorConfirmPassword(final String? text) => errorConfirmPassword = text ?? '';

  void reset() {
    errorCurrentPassword = '';
    errorReplacePassword = '';
    errorConfirmPassword = '';
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
