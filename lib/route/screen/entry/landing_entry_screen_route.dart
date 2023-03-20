import 'package:flutter/material.dart';

import '../../../component/button/text_button_component.dart';
import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/navigator_utility.dart';
import 'authenticate_entry_screen_route.dart';
import 'register_entry_screen_route.dart';

class LandingEntryScreenRoute extends StatelessWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const LandingEntryScreenRoute(),
    );
  }

  final controller = const _ScreenController._();

  const LandingEntryScreenRoute({
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
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              AppUtility.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'The goals of this application is to develop a template that ensure consistency and best coding practices for future flutter application.',
              textAlign: TextAlign.center,
            ),
            TextButtonComponent.submit(
              title: 'Sign In',
              margin: const EdgeInsets.only(
                top: 24,
                left: 4,
                right: 4,
                bottom: 12,
              ),
              style: TextButtonStyle.elevated,
              onPressed: () => controller.signIn(context),
            ),
            TextButtonComponent.submit(
              title: 'Sign Up',
              style: TextButtonStyle.outlined,
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
  const _ScreenController._();

  void signIn(final BuildContext context) {
    AuthenticateEntryScreenRoute.navigate(context);
  }

  void signUp(final BuildContext context) {
    RegisterEntryScreenRoute.navigate(context);
  }
}
