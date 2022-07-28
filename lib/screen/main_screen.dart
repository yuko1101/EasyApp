import 'package:flutter/material.dart';
import 'base_screens/base_screen.dart';
import 'drawer.dart';
import 'page_manager.dart';

/// MainScreen is the main screen of the app. Automatically updates its screen on page changes.
class MainScreen extends StatelessWidget {
  static const GlobalObjectKey<ScaffoldState> scaffoldKey =
      GlobalObjectKey("main_screen");

  static late SideMenu sideMenu;

  MainScreen({
    required SideMenu sideMenu,
    Key? key,
  }) : super(key: key) {
    // ignore: prefer_initializing_formals
    MainScreen.sideMenu = sideMenu;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => PageManager.goBack(context),
      child: ValueListenableBuilder<BaseScreen>(
        valueListenable: PageManager.screenNotifier,
        builder: (_, baseScreen, __) {
          return baseScreen;
        },
      ),
    );
  }
}
