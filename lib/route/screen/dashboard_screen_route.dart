import 'package:flutter/material.dart';

import '../../component/button/icon_button_component.dart';
import '../../component/template/screen_template_component.dart';
import '../../utility/navigator_utility.dart';
import 'setting/dashboard_setting_screen_route.dart';

class DashboardScreenRoute extends StatefulWidget {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const DashboardScreenRoute(),
    );
  }

  final controller = const _ScreenController._();

  const DashboardScreenRoute({
    super.key,
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

class _ScreenController {
  const _ScreenController._();

  void viewSettings(final BuildContext context) async {
    DashboardSettingScreenRoute.navigate(context);
  }
}
