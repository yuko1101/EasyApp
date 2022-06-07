import 'package:flutter/material.dart';

/// BaseScreen is a base class to create a screen.
class BaseScreen {
  const BaseScreen({
    required this.screen,
    this.appBar,
    this.footer,
    this.endDrawer,
    this.previousPage,
  });

  /// The appbar of the screen which is displayed on top of the screen.
  final PreferredSizeWidget? appBar;

  /// The main content of the screen.
  final Widget screen;

  /// The footer of the screen which is displayed at the bottom of the screen.
  final StatelessWidget? footer;

  /// The endDrawer of the screen which is at the right side of the screen.
  /// You can drag the endDrawer to open it.
  final StatelessWidget? endDrawer;

  /// The previous page of the screen.
  /// If the previous page is null, open the home screen instead of closing app.
  final BaseScreen? previousPage;
}
