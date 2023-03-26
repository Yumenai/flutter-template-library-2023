import 'package:flutter/material.dart';

import '../../component/template/screen_template_component.dart';
import '../../component/view/image_view_component.dart';
import '../../controller/app_controller.dart';
import '../../service/app_service.dart';
import '../controller/splash_controller_route.dart';

class SplashScreenRoute extends StatefulWidget {
  final SplashControllerRoute controller;

  const SplashScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  State<SplashScreenRoute> createState() => _SplashScreenRouteState();
}

class _SplashScreenRouteState extends State<SplashScreenRoute> {
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
            Text(
              AppService.instance?.name ?? '',
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
