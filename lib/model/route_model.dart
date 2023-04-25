import 'package:flutter/material.dart';

class RouteModel {
  final Widget screen;
  final Future<dynamic>? Function(Widget) _onNavigate;

  const RouteModel({
    required this.screen,
    required final Future<dynamic>? Function(Widget) onNavigate,
  }) : _onNavigate = onNavigate;

  Future<dynamic>? navigate() => _onNavigate(screen);
}
