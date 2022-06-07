library easy_app;

import 'package:easy_app/screen/base_screen.dart';
import 'package:easy_app/screen/main_screen.dart';
import 'package:easy_app/screen/page_manager.dart';
import 'package:easy_app/utils/languages.dart';
import 'package:easy_app/utils/network_utils.dart';
import 'package:easy_app/utils/os.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EasyApp {
  static late String localPath;

  static bool _pathInitialized = false;

  static Future<void> initializePath() async {
    if (_pathInitialized) return;
    if (OS.getOS() == OSType.web) return;
    localPath = (await getApplicationDocumentsDirectory()).path;
    _pathInitialized = true;
  }

  static Future<void> initialize({
    bool activateConnectionChecker = true,
    List<String> languages = const ["en_US"],
    required BaseScreen homeScreen,
  }) async {
    if (OS.getOS() != OSType.web && !_pathInitialized) {
      localPath = (await getApplicationDocumentsDirectory()).path;
      _pathInitialized = true;
    }
    if (activateConnectionChecker) NetworkUtils.init();
    if (languages.isNotEmpty) await Language.init(languages);
    PageManager.init(homeScreen);
  }

  static BaseScreen get currentScreen => PageManager.screenNotifier.value;
  static void pushPage(BuildContext context, BaseScreen screen) {
    if (MainScreen.scaffoldKey.currentState?.isDrawerOpen ?? false) {
      MainScreen.scaffoldKey.currentState!.closeDrawer();
    }
    PageManager.pushPage(context, screen);
  }

  static void popPage(BuildContext context) => PageManager.goBack(context);
}
