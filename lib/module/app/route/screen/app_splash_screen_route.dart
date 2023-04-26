import 'package:flutter/material.dart';

import '../../../../view/template/screen_template_view.dart';
import '../../../../component/view/image_view_component.dart';
import '../../../../provider/app_provider.dart';
import '../../../../utility/app_utility.dart';
import '../controller/app_splash_controller_route.dart';

class AppSplashScreenRoute extends StatefulWidget {
  final AppSplashControllerRoute controller;

  const AppSplashScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  State<AppSplashScreenRoute> createState() => _AppSplashScreenRouteState();
}

class _AppSplashScreenRouteState extends State<AppSplashScreenRoute> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.initialise(this);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      layout: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            SizedBox.square(
              dimension: 200,
              child: ImageViewComponent.asset(
                AppProvider.listen(context).image.appSplash,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 24,
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
                    fontSize: 24,
                  ),
                );
              },
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
