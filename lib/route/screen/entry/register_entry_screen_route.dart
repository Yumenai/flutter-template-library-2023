import 'package:flutter/material.dart';

import '../../../component/button/text_button_component.dart';
import '../../../component/input/text_input_component.dart';
import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../component/view/text_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../service/repository_service.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/navigator_utility.dart';
import 'splash_entry_screen_route.dart';

class RegisterEntryScreenRoute extends StatelessWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: RegisterEntryScreenRoute(),
    );
  }

  final controller = _ScreenController._();

  RegisterEntryScreenRoute({
    super.key,
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
              controller: controller.idInputController,
            ),
            TextInputComponent(
              label: 'Name',
              controller: controller.nameInputController,
            ),
            TextInputComponent.email(
              label: 'Email',
              controller: controller.emailInputController,
            ),
            SecureTextInputComponent(
              label: 'Password',
              controller: controller.passwordInputController,
            ),
            SecureTextInputComponent(
              label: 'Confirm Password',
              controller: controller.confirmPasswordInputController,
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

class _ScreenController {
  final idInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  _ScreenController._();

  void signUp(final BuildContext context) async {
    await RepositoryService.storage.key.setAccessToken('accessToken');

    if (!context.mounted) return;

    SplashEntryScreenRoute.navigate(context);
  }
}
