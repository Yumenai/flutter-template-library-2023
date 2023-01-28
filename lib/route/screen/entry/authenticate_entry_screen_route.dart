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

class AuthenticateEntryScreenRoute extends StatelessWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: AuthenticateEntryScreenRoute(),
    );
  }

  final controller = _ScreenController._();

  AuthenticateEntryScreenRoute({
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
              'Authenticate',
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

class _ScreenController {
  final idInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  _ScreenController._();

  void signIn(final BuildContext context) async {
    await RepositoryService.storage.key.setAccessToken('accessToken');

    if (!context.mounted) return;

    SplashEntryScreenRoute.navigate(context);
  }
}
