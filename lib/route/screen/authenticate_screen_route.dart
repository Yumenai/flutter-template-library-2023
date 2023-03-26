import 'package:flutter/material.dart';

import '../../component/button/text_button_component.dart';
import '../../component/input/text_input_component.dart';
import '../../component/template/screen_template_component.dart';
import '../../component/view/image_view_component.dart';
import '../../controller/app_controller.dart';
import '../../service/app_service.dart';
import '../controller/authenticate_controller_route.dart';

class AuthenticateScreenRoute extends StatelessWidget {
  final AuthenticationControllerRoute controller;

  const AuthenticateScreenRoute({
    super.key,
    required this.controller,
  });

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
              fit: BoxFit.contain,
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Authenticate',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              AppService.instance?.name ?? '',
              textAlign: TextAlign.center,
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
              controller: controller.idInputController,
            ),
            SecureTextInputComponent(
              label: 'Password',
              controller: controller.passwordInputController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextButtonComponent.submit(
              title: 'Sign In',
              style: TextButtonStyle.elevated,
              onPressed: () => controller.signIn(context),
            ),
          ],
        ),
      ),
      enableOverlapHeader: true,
    );
  }
}
