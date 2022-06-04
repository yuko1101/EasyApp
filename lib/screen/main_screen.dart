import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import 'base_screen.dart';
import 'drawer.dart';
import 'page_manager.dart';

class MainScreen extends StatelessWidget {
  static const GlobalObjectKey<ScaffoldState> scaffoldKey =
      GlobalObjectKey("main_screen");

  const MainScreen({
    required this.sideMenu,
    Key? key,
  }) : super(key: key);

  final SideMenu sideMenu;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => PageManager.goBack(context),
      child: ValueListenableBuilder<BaseScreen>(
        valueListenable: PageManager.screenNotifier,
        builder: (_, baseScreen, __) {
          if (Responsive.isDesktop(context)) {
            return Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: false,
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sideMenu,
                  Expanded(child: baseScreen.screen),
                  baseScreen.endDrawer ?? const SizedBox(width: 0, height: 0)
                ],
              ),
            );
          }
          return Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: baseScreen.appBar,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: baseScreen.footer != null
                  ? [Expanded(child: baseScreen.screen), baseScreen.footer!]
                  : [Expanded(child: baseScreen.screen)],
            ),
            drawer: sideMenu,
            endDrawer: baseScreen.endDrawer,
          );
        },
      ),
    );
  }
}
