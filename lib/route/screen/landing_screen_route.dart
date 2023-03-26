import 'package:flutter/material.dart';

import '../../component/button/text_button_component.dart';
import '../../component/template/screen_template_component.dart';
import '../../component/view/image_view_component.dart';
import '../../controller/app_controller.dart';
import '../../utility/app_utility.dart';
import '../controller/landing_controller_route.dart';

class LandingScreenRoute extends StatelessWidget {
  final LandingControllerRoute controller;

  const LandingScreenRoute({
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
