library easy_app;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_app/screen/base_screen.dart';
import 'package:easy_app/screen/main_screen.dart';
import 'package:easy_app/screen/page_manager.dart';
import 'package:easy_app/utils/languages.dart';
import 'package:easy_app/utils/network_utils.dart';
import 'package:easy_app/utils/os.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EasyApp {
  /// The path to the local application directory.
  static late String localPath;

  static bool _pathInitialized = false;

  /// Initializes the path for the app.
  /// This is only necessary if the HomeScreen requires access to the local path,
  /// or config files.
  static Future<void> initializePath() async {
    if (_pathInitialized) return;
    if (OS.getOS() == OSType.web) return;
    localPath = (await getApplicationDocumentsDirectory()).path;
    _pathInitialized = true;
  }

  /// Initializes EasyApp. You must call this before running the app.
  static Future<void> initialize({
    bool activateConnectionChecker = true,
    List<String> languages = const ["en_US"],
    required BaseScreen homeScreen,
    ConnectivityResult minimumNetworkLevel = ConnectivityResult.mobile,
  }) async {
    // Initialize the path if it hasn't been initialized yet.
    if (OS.getOS() != OSType.web && !_pathInitialized) {
      localPath = (await getApplicationDocumentsDirectory()).path;
      _pathInitialized = true;
    }
    if (activateConnectionChecker) NetworkUtils.init(minimumNetworkLevel);
    if (languages.isNotEmpty) await Language.init(languages);
    PageManager.init(homeScreen);
  }

  /// The current screen of MainScreen.
  static BaseScreen get currentScreen => PageManager.screenNotifier.value;

  /// Pushes a screen to the stack.
  static void pushPage(BuildContext context, BaseScreen screen) {
    if (MainScreen.scaffoldKey.currentState?.isDrawerOpen ?? false) {
      MainScreen.scaffoldKey.currentState!.closeDrawer();
    }
    PageManager.pushPage(context, screen);
  }

  /// Pops the current screen. And returns to the previous screen.
  static void popPage(BuildContext context) => PageManager.goBack(context);

  /// Sets the minimum network level for the app.
  static void setMinimumNetworkLevel(ConnectivityResult level) =>
      NetworkUtils.setMinimumNetworkLevel(level);
}
