import 'package:flutter/material.dart';

import '../../../../component/button/text_button_component.dart';
import '../../../../component/input/text_input_component.dart';
import '../../../../provider/app_provider.dart';
import '../../../../view/template/screen_template_view.dart';
import '../controller/user_deletion_controller_route.dart';

class UserDeletionScreenRoute extends StatelessWidget {
  final UserDeletionControllerRoute controller;

  const UserDeletionScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      infoTitle: 'Delete Account',
      layout: Form(
        key: controller.form.formStateKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          children: [
            SecureTextInputComponent(
              label: 'Password',
              controller: controller.form.currentPasswordInputController,
              onValidate: controller.form.validateCurrentPassword,
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
        title: 'Delete Account',
        style: TextButtonStyle.elevated,
        foregroundColor: AppProvider.listen(context).color.onErrorContainer,
        backgroundColor: AppProvider.listen(context).color.errorContainer,
        margin: const EdgeInsets.only(
          top: 12,
          left: 32,
          right: 32,
          bottom: 24,
        ),
        onPressed: () => controller.delete(context),
      ),
    );
  }
}
