import 'package:easy_app/screen/main_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import 'base_screen.dart';

class ScaffoldScreen extends BaseScreen {
  const ScaffoldScreen({
    required this.body,
    this.appBar,
    this.footer,
    this.endDrawer,
    BaseScreen? previousPage,
    this.activeDrawer = true,
    Key? key,
  }) : super(previousPage: previousPage, key: key);

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

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Scaffold(
        key: MainScreen.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (activeDrawer) MainScreen.sideMenu,
            Expanded(child: body),
            endDrawer ?? const SizedBox(width: 0, height: 0)
          ],
        ),
      );
    }
    return Scaffold(
      key: MainScreen.scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: footer != null
            ? [Expanded(child: body), footer!]
            : [Expanded(child: body)],
      ),
      drawer: activeDrawer ? MainScreen.sideMenu : null,
      endDrawer: endDrawer,
    );
  }
}
