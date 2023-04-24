import 'package:flutter/material.dart';

import '../../../../component/button/text_button_component.dart';
import '../../../../component/input/text_input_component.dart';
import '../../../../view/template/screen_template_view.dart';
import '../controller/user_profile_controller_route.dart';

class UserProfileScreenRoute extends StatelessWidget {
  final UserProfileControllerRoute controller;

  const UserProfileScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    controller.setup(context);

    return ScreenTemplateView(
      infoTitle: 'Profile',
      layout: Form(
        key: controller.form.formStateKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextInputComponent.name(
              label: 'Name',
              controller: controller.form.nameInputController,
              onValidate: controller.form.validateName,
            ),
            TextInputComponent.email(
              label: 'Email',
              controller: controller.form.emailInputController,
              onValidate: controller.form.validateEmail,
            ),
            ActionTextInputComponent(
              label: 'Birthdate',
              controller: controller.form.birthdateInputController,
              onSelect: () => controller.selectBirthdate(context),
            ),
          ],
        ),
      ),
      navigatorBottom: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButtonComponent.submit(
            title: 'Save',
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            style: TextButtonStyle.elevated,
            onPressed: () => controller.updateProfile(context),
          ),
          const Text(
            'Last Update: 1 March 2023',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
