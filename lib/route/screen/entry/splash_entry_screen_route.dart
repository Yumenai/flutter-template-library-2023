import 'package:flutter/material.dart';

import '../../../component/template/screen_template_component.dart';
import '../../../component/view/image_view_component.dart';
import '../../../component/view/text_view_component.dart';
import '../../../controller/app_controller.dart';
import '../../../utility/app_utility.dart';
import '../../controller/entry/splash_entry_controller_route.dart';

class SplashEntryScreenRoute extends StatefulWidget {
  final SplashEntryControllerRoute controller;

  const SplashEntryScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

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
