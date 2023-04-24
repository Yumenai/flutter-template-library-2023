import 'package:flutter/material.dart';

import '../../../../utility/dialog_utility.dart';
import '../../../../utility/format_utility.dart';
import '../../../../utility/interface_utility.dart';
import '../../user_module.dart';

class UserDeletionControllerRoute {
  final form = _UserPasswordForm();
  final void Function() viewSplash;
  final Future<void> Function() onDeleteAccount;

  UserDeletionControllerRoute({
    required this.viewSplash,
    required this.onDeleteAccount,
  });

  void delete(final BuildContext context) async {
    final isClearing = await InterfaceUtility.isFocusClearing(context);

    if (isClearing) return;

    if (form.isNotValid()) return;

    if (!context.mounted) return;

    final isSuccess = await UserModule.of(context).repository.deleteAccount(
      context,
      password: form.currentPasswordInputController.text,
    );

    if (!isSuccess) return;

    if (!context.mounted) return;

    await DialogUtility.showAlert(
      context,
      title: 'Account Deleted!',
      message: 'Thank you for giving this application a try. Do come back next time for a try.',
    );

    await onDeleteAccount();

    viewSplash();
  }
}

class _UserPasswordForm {
  final formStateKey = GlobalKey<FormState>();

  final currentPasswordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  String errorCurrentPassword = '';
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
    if (currentPasswordInputController.text != confirmPasswordInputController.text) {
      return 'Please ensure the password matched the confirm password input fields';
    }

    return errorCurrentPassword.isEmpty ? _validate(text) : errorCurrentPassword;
  }

  String? validateConfirmPassword(final String? text) {
    if (currentPasswordInputController.text != confirmPasswordInputController.text) {
      return 'Please ensure the confirm password matched the password input fields';
    }

    return errorConfirmPassword.isEmpty ? _validate(text) : errorConfirmPassword;
  }

  void setErrorCurrentPassword(final String? text) => errorCurrentPassword = text ?? '';

  void setErrorConfirmPassword(final String? text) => errorConfirmPassword = text ?? '';

  void reset() {
    errorCurrentPassword = '';
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
