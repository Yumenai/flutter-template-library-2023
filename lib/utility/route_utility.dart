import 'package:flutter/material.dart';

class RouteUtility {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic>? push(final Widget screen) {
    return navigatorKey.currentState?.push(_pageRoute(screen));
  }

  static Future<dynamic>? pushBase(final Widget screen) {
    return navigatorKey.currentState?.pushAndRemoveUntil(_pageRoute(screen), (_) => false);
  }

  static Future<dynamic>? pushReplacement(final Widget screen) {
    return navigatorKey.currentState?.pushReplacement(_pageRoute(screen));
  }

  /// Build animation screen route
  static Route _pageRoute(final Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    );
  }

  const RouteUtility._();
}
