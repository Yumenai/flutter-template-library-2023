import 'package:flutter/material.dart';

class RouteModel {
  final Widget Function() _onBuild;
  final Future<dynamic>? Function(Widget) _onNavigate;

  const RouteModel({
    required final Widget Function() onBuild,
    required final Future<dynamic>? Function(Widget) onNavigate,
  }) : _onBuild = onBuild,
        _onNavigate = onNavigate;

  Widget build() => _onBuild();

  Future<dynamic>? navigate() => _onNavigate(_onBuild());
}
