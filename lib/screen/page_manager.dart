import 'package:flutter/material.dart';
import 'base_screens/base_screen.dart';

/// PageManager navigates between screens.
class PageManager {
  static List<BaseScreen> pages = [];
  static late ValueNotifier<BaseScreen> screenNotifier;
  static late BaseScreen homeScreen;

  /// Initializes the PageManager with the home screen.
  static init(BaseScreen homeScreen) {
    screenNotifier = ValueNotifier<BaseScreen>(homeScreen);
    PageManager.homeScreen = homeScreen;
  }

  /// Goes back to the previous screen.
  static bool goBack(BuildContext context) {
    if (screenNotifier.value.runtimeType ==
        PageManager.homeScreen.runtimeType) {
      return false;
    }
    if (screenNotifier.value.previousPage != null) {
      pages.clear();
      screenNotifier.value = screenNotifier.value.previousPage!;
    } else {
      if (pages.length < 2) {
        screenNotifier.value = homeScreen;
      } else {
        pages.removeLast();
        screenNotifier.value = pages.removeLast();
      }
    }
    return false;
  }

  /// Pushes a screen to the stack.
  static void pushPage(BuildContext context, BaseScreen page, {close = false}) {
    if (close) Navigator.pop(context); //close SideMenu
    screenNotifier.value = page;
  }
}
