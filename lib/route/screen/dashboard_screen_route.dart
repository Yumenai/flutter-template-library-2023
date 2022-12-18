import 'package:flutter/material.dart';

import '../../component/button/icon_button_component.dart';
import '../../component/template/screen_template_component.dart';
import '../controller/dashboard_controller_route.dart';

class DashboardScreenRoute extends StatefulWidget {
  final DashboardControllerRoute controller;

  const DashboardScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

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
          icon: const Icon(Icons.exit_to_app),
          hint: 'Sign Out',
          onPressed: () {
            widget.controller.signOut(this);
          },
        ),
      ],
    );
  }
}
