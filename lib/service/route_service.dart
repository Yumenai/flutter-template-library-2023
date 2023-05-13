import 'package:flutter/material.dart';

class RouteService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> push<T>(final Widget screen) async {
    final result = await navigatorKey.currentState?.push(_pageRoute(screen));

    if (result is T) return result;

    return null;
  }

  static Future<T?> pushBase<T>(final Widget screen) async {
    final result = await navigatorKey.currentState?.pushAndRemoveUntil(_pageRoute(screen), (_) => false);

    if (result is T) return result;

    return null;
  }

  static Future<T?> pushReplacement<T>(final Widget screen) async {
    final result = await navigatorKey.currentState?.pushReplacement(_pageRoute(screen));

    if (result is T) return result;

    return null;
  }

  /// Build animation screen route
  static Route _pageRoute(final Widget screen) {
    return MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    );
  }

  const RouteService._();
}
