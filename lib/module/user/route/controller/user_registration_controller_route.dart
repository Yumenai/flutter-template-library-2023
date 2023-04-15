import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';
import '../../../../utility/format_utility.dart';
import '../../../../utility/interface_utility.dart';

class UserRegistrationControllerRoute {
  final form = _UserRegisterForm();

  UserRegistrationControllerRoute();

  void signUp(final BuildContext context) async {
    final isClearing = await InterfaceUtility.isFocusClearing(context);

    if (isClearing) return;

    if (form.isNotValid()) return;

    RepositoryDirectory.app?.sessionRefreshToken = 'sample-refresh-token';

    if (!context.mounted) return;

    RouteDirectory.app.navigator.splash();
  }
}

class _UserRegisterForm {
  final formStateKey = GlobalKey<FormState>();

  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  String errorId = '';
  String errorName = '';
  String errorEmail = '';
  String errorPassword = '';
  String errorConfirmPassword = '';

  _UserRegisterForm();

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

  String? validateName(final String? text) {
    return errorName.isEmpty ? _validate(text) : errorName;
  }

  String? validateEmail(final String? text) {
    return errorEmail.isEmpty ? _validate(text) : errorEmail;
  }

  String? validatePassword(final String? text) {
    if (passwordInputController.text != confirmPasswordInputController.text) {
      return 'Please ensure the password matched the confirm password input fields';
    }

    return errorPassword.isEmpty ? _validate(text) : errorPassword;
  }

  String? validateConfirmPassword(final String? text) {
    if (passwordInputController.text != confirmPasswordInputController.text) {
      return 'Please ensure the confirm password matched the password input fields';
    }

    return errorConfirmPassword.isEmpty ? _validate(text) : errorConfirmPassword;
  }

  void setErrorId(final String? text) => errorId = text ?? '';

  void setErrorName(final String? text) => errorPassword = text ?? '';

  void setErrorEmail(final String? text) => errorPassword = text ?? '';

  void setErrorPassword(final String? text) => errorPassword = text ?? '';

  void setErrorConfirmPassword(final String? text) => errorPassword = text ?? '';

  void reset() {
    errorId = '';
    errorName = '';
    errorEmail = '';
    errorPassword = '';
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
