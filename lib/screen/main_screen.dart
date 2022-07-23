import 'package:easy_app/screen/base_screens/widget_screen.dart';
import 'package:easy_app/screen/exceptions/unknown_base_screen_exception.dart';
import 'package:easy_app/screen/base_screens/scaffold_screen.dart';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import 'base_screens/base_screen.dart';
import 'drawer.dart';
import 'page_manager.dart';

/// MainScreen is the main screen of the app. Automatically updates its screen on page changes.
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
          if (baseScreen is ScaffoldScreen) {
            if (Responsive.isDesktop(context)) {
              return Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (baseScreen.activeDrawer) sideMenu,
                    Expanded(child: baseScreen.body),
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
                    ? [Expanded(child: baseScreen.body), baseScreen.footer!]
                    : [Expanded(child: baseScreen.body)],
              ),
              drawer: baseScreen.activeDrawer ? sideMenu : null,
              endDrawer: baseScreen.endDrawer,
            );
          } else if (baseScreen is WidgetScreen) {
            return baseScreen.child;
          } else {
            throw UnknownBaseScreenException();
          }
        },
      ),
    );
  }
}
