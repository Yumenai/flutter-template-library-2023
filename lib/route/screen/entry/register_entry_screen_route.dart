import 'package:flutter/material.dart';

import '../../../component/button/text_button_component.dart';
import '../../../component/input/text_input_component.dart';
import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../component/view/text_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../utility/app_utility.dart';
import '../../controller/entry/register_entry_controller_route.dart';

class RegisterEntryScreenRoute extends StatefulWidget {
  final RegisterEntryControllerRoute controller;

  const RegisterEntryScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RegisterEntryScreenRoute> createState() => _RegisterEntryScreenRouteState();
}

class _RegisterEntryScreenRouteState extends State<RegisterEntryScreenRoute> {
  @override
  Widget build(BuildContext context) {
    return ScreenTemplateComponent(
      layout: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            ImageViewComponent.asset(
              AppController.listen(context).image.app.splash,
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
            TextViewComponent.future(
              AppUtility.name,
              align: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextInputComponent(
              label: 'ID',
              controller: widget.controller.idInputController,
            ),
            TextInputComponent(
              label: 'Name',
              controller: widget.controller.nameInputController,
            ),
            TextInputComponent.email(
              label: 'Email',
              controller: widget.controller.emailInputController,
            ),
            SecureTextInputComponent(
              label: 'Password',
              controller: widget.controller.passwordInputController,
            ),
            SecureTextInputComponent(
              label: 'Confirm Password',
              controller: widget.controller.confirmPasswordInputController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextButtonComponent.submit(
              title: 'Sign Up',
              style: TextButtonStyle.elevated,
              onPressed: () => widget.controller.signUp(this),
            ),
          ],
        ),
      ),
      enableOverlapHeader: true,
    );
  }
}
