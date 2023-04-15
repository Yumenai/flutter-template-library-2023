import 'package:flutter/material.dart';

import '../../../../component/button/text_button_component.dart';
import '../../../../component/input/text_input_component.dart';
import '../../../../view/template/screen_template_view.dart';
import '../controller/user_password_controller_route.dart';

class UserPasswordScreenRoute extends StatelessWidget {
  final UserPasswordControllerRoute controller;

  const UserPasswordScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      infoTitle: 'Change Password',
      layout: Form(
        key: controller.form.formStateKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          children: [
            SecureTextInputComponent(
              label: 'Current Password',
              controller: controller.form.currentPasswordInputController,
              onValidate: controller.form.validateCurrentPassword,
            ),
            SecureTextInputComponent(
              label: 'New Password',
              controller: controller.form.replacePasswordInputController,
              onValidate: controller.form.validateReplacePassword,
            ),
            SecureTextInputComponent(
              label: 'Confirm Password',
              controller: controller.form.confirmPasswordInputController,
              onValidate: controller.form.validateConfirmPassword,
            ),
          ],
        ),
      ),
      navigatorBottom: TextButtonComponent.submit(
        title: 'Update',
        style: TextButtonStyle.elevated,
        margin: const EdgeInsets.only(
          top: 12,
          left: 32,
          right: 32,
          bottom: 24,
        ),
        onPressed: () => controller.update(context),
      ),
    );
  }
}
