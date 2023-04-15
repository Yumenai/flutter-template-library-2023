import 'package:flutter/material.dart';

import '../../../../component/button/text_button_component.dart';
import '../../../../component/input/text_input_component.dart';
import '../../../../view/template/screen_template_view.dart';
import '../../../../component/view/image_view_component.dart';
import '../../../../provider/app_provider.dart';
import '../../../../utility/app_utility.dart';
import '../controller/user_registration_controller_route.dart';

class UserRegistrationScreenRoute extends StatelessWidget {
  final UserRegistrationControllerRoute controller;

  const UserRegistrationScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      layout: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            ImageViewComponent.asset(
              AppProvider.listen(context).image.appSplash,
              fit: BoxFit.contain,
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder(
              future: AppUtility.name,
              builder: (context, asyncSnapshot) {
                return Text(
                  asyncSnapshot.data ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Form(
              key: controller.form.formStateKey,
              child: Column(
                children: [
                  TextInputComponent(
                    label: 'ID',
                    controller: controller.form.idInputController,
                    onValidate: controller.form.validateId,
                  ),
                  TextInputComponent(
                    label: 'Name',
                    controller: controller.form.nameInputController,
                    onValidate: controller.form.validateName,
                  ),
                  TextInputComponent.email(
                    label: 'Email',
                    controller: controller.form.emailInputController,
                    onValidate: controller.form.validateEmail,
                  ),
                  SecureTextInputComponent(
                    label: 'Password',
                    controller: controller.form.passwordInputController,
                    onValidate: controller.form.validatePassword,
                  ),
                  SecureTextInputComponent(
                    label: 'Confirm Password',
                    controller: controller.form.confirmPasswordInputController,
                    onValidate: controller.form.validateConfirmPassword,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextButtonComponent.submit(
              title: 'Sign Up',
              style: TextButtonStyle.elevated,
              onPressed: () => controller.signUp(context),
            ),
          ],
        ),
      ),
      enableOverlapHeader: true,
    );
  }
}
