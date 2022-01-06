import 'package:flutter/material.dart';

typedef WidgetFactory = Widget Function();

class TabMeta {
  final String label;
  final Icon icon;
  final WidgetFactory factory;

  Widget? _widget;

  Widget get widget => _widget ??= factory();

  TabMeta({required this.label, required this.icon, required this.factory});
}
