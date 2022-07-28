import 'package:easy_app/screen/base_screens/base_screen.dart';
import 'package:flutter/material.dart';

class WidgetScreen extends BaseScreen {
  const WidgetScreen({
    required this.child,
    BaseScreen? previousPage,
    Key? key,
  }) : super(previousPage: previousPage, key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
