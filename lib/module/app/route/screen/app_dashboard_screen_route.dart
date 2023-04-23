import 'package:flutter/material.dart';

import '../../../../component/button/icon_button_component.dart';
import '../../../../view/template/screen_template_view.dart';
import '../controller/app_dashboard_controller_route.dart';

class AppDashboardScreenRoute extends StatefulWidget {
  final AppDashboardControllerRoute controller;

  const AppDashboardScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  State<AppDashboardScreenRoute> createState() => _AppDashboardScreenRouteState();
}

class _AppDashboardScreenRouteState extends State<AppDashboardScreenRoute> {
  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      infoTitle: 'Flutter Template Library',
      infoActionList: [
        IconButtonComponent(
          icon: const Icon(Icons.settings),
          hint: 'Settings',
          onPressed: () => widget.controller.viewSettings(context),
        ),
      ],
    );
  }
}
