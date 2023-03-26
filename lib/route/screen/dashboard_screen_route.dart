import 'package:flutter/material.dart';

import '../../component/button/icon_button_component.dart';
import '../../component/template/screen_template_component.dart';
import '../controller/dashboard_controller_route.dart';

class DashboardScreenRoute extends StatefulWidget {
  final DashboardControllerRoute controller;

  const DashboardScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  State<DashboardScreenRoute> createState() => _DashboardScreenRouteState();
}

class _DashboardScreenRouteState extends State<DashboardScreenRoute> {
  @override
  Widget build(BuildContext context) {
    return ScreenTemplateComponent(
      infoTitle: 'Flutter Template Library',
      infoActionList: [
        IconButtonComponent(
          icon: const Icon(Icons.settings),
          hint: 'Settings',
          onPressed: () {
            widget.controller.viewSettings(context);
          },
        ),
      ],
    );
  }
}
