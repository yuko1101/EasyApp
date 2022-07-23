import 'package:flutter/material.dart';

import 'base_screen.dart';

class ScaffoldScreen extends BaseScreen {
  ScaffoldScreen({
    required this.body,
    this.appBar,
    this.footer,
    this.endDrawer,
    BaseScreen? previousPage,
    this.activeDrawer = true,
  }) : super(previousPage: previousPage);

  /// The appbar of the screen which is displayed on top of the screen.
  final PreferredSizeWidget? appBar;

  /// The main content of the screen.
  final Widget body;

  /// The footer of the screen which is displayed at the bottom of the screen.
  final StatelessWidget? footer;

  /// The endDrawer of the screen which is at the right side of the screen.
  /// You can drag the endDrawer to open it.
  final StatelessWidget? endDrawer;

  /// Whether can open the drawer in this screen
  final bool activeDrawer;
}
