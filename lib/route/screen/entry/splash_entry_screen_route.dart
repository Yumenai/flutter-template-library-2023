import 'package:flutter/material.dart';

import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../component/view/text_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../service/repository_service.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/navigator_utility.dart';
import '../dashboard_screen_route.dart';
import 'landing_entry_screen_route.dart';

class SplashEntryScreenRoute extends StatefulWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const SplashEntryScreenRoute(),
    );
  }

  final controller = const _ScreenController._();

  const SplashEntryScreenRoute({
    super.key,
  });

  @override
  State<SplashEntryScreenRoute> createState() => _SplashEntryScreenRouteState();
}

class _SplashEntryScreenRouteState extends State<SplashEntryScreenRoute> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.initialise(this);
    });
    super.initState();
  }

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
            TextViewComponent.future(
              AppUtility.name,
              align: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const UnconstrainedBox(
              child: CircularProgressIndicator(),
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

  void initialise(final State state) async {
    await Future.delayed(const Duration(
      seconds: 1,
    ));

    if (!state.mounted) return;

    final accessToken = await RepositoryService.storage.key.refreshToken;

    if (!state.mounted) return;

    if (accessToken.isEmpty) {
      LandingEntryScreenRoute.navigate(state.context);
    } else {
      DashboardScreenRoute.navigate(state.context);
    }
  }
}
