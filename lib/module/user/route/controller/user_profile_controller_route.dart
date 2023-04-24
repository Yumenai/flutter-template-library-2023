import 'package:flutter/material.dart';

import '../../../../utility/dialog_utility.dart';
import '../../../../utility/format_utility.dart';
import '../../../../utility/interface_utility.dart';
import '../../user_module.dart';

class UserProfileControllerRoute {
  final form = _UserProfileForm();
  DateTime? birthdate;

  UserProfileControllerRoute();

  void setup(final BuildContext context) {
    final profileModel = UserModule.of(context).repository.profileModel;

    if (profileModel == null) return;
    form.nameInputController.text = profileModel.name;
    form.emailInputController.text = profileModel.email;

    birthdate = profileModel.birthdate;
    form.birthdateInputController.text = '${FormatUtility.date(birthdate)} (${DateTime.now().year - (birthdate?.year ?? DateTime.now().year)})';
  }

  void selectBirthdate(final BuildContext context) async {
    final birthdate = await DialogUtility.showDateSelector(
      context,
      title: 'Update Birthdate',
      lastDate: DateTime.now(),
    );

    if (birthdate == null) return;

    this.birthdate = birthdate;

    form.birthdateInputController.text = '${FormatUtility.date(birthdate)} (${DateTime.now().year - birthdate.year})';
  }

  void updateProfile(final BuildContext context) async {
    final isClearing = await InterfaceUtility.isFocusClearing(context);

    if (isClearing) return;

    if (form.isNotValid()) return;

    if (!context.mounted) return;

    final model = await UserModule.of(context).repository.updateProfile(
      context,
      name: form.nameInputController.text,
      email: form.emailInputController.text,
      birthdate: birthdate,
    );

    if (model == null) return;

    if (!context.mounted) return;

    await DialogUtility.showAlert(
      context,
      title: 'Success',
      message: 'User Profile Updated!',
    );

    if (!context.mounted) return;

    Navigator.pop(context);
  }
}

class _UserProfileForm {
  final formStateKey = GlobalKey<FormState>();

  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final birthdateInputController = TextEditingController();

  String errorName = '';
  String errorEmail = '';

  _UserProfileForm();

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

  String? validateName(final String? text) {
    return errorName.isEmpty ? _validate(text) : errorName;
  }

  String? validateEmail(final String? text) {
    return errorEmail.isEmpty ? _validate(text) : errorEmail;
  }

  void setErrorName(final String? text) => errorName = text ?? '';

  void setErrorEmail(final String? text) => errorEmail = text ?? '';

  void reset() {
    errorName = '';
    errorEmail = '';
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

