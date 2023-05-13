import 'package:flutter/material.dart';

class RouteModel<T> {
  final Widget Function() _onBuild;
  final Future<T?> Function(Widget) _onNavigate;

  const RouteModel({
    required final Widget Function() onBuild,
    required final Future<T?> Function(Widget) onNavigate,
  }) : _onBuild = onBuild,
        _onNavigate = onNavigate;

  Widget build() => _onBuild();

  Future<T?> navigate() => _onNavigate(_onBuild());
}
