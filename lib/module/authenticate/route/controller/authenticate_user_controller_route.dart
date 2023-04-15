import 'package:flutter/material.dart';

import '../../../../directory/repository_directory.dart';
import '../../../../directory/route_directory.dart';
import '../../../../utility/format_utility.dart';
import '../../../../utility/interface_utility.dart';

class AuthenticationUserControllerRoute {
  final form = _AuthenticateUserForm();

  AuthenticationUserControllerRoute();

  void signIn(final BuildContext context) async {
    final isClearing = await InterfaceUtility.isFocusClearing(context);

    if (isClearing) return;

    if (form.isNotValid()) return;

    RepositoryDirectory.app?.sessionRefreshToken = 'sample-refresh-token';

    if (!context.mounted) return;

    RouteDirectory.app.navigator.splash();
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
