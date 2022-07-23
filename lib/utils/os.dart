import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// OS is a class that helps you to create OS-adaptive widgets.
class OS extends StatelessWidget {
  final Widget? android;
  final Widget? iOS;
  final Widget? windows;
  final Widget? macOS;
  final Widget? linux;
  final Widget? fuchsia;
  final Widget? web;
  final Widget? unknown;

  const OS({
    Key? key,
    this.android,
    this.iOS,
    this.windows,
    this.macOS,
    this.linux,
    this.fuchsia,
    this.web,
    this.unknown,
  }) : super(key: key);

  /// Returns whether the OS is either Android or iOS.
  static bool isMobile() => Platform.isAndroid || Platform.isIOS;

  /// Returns whether the OS is either Windows, macOS or Linux.
  static bool isDesktopOrLaptop() =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  /// Returns whether the OS is Web.
  static bool isWeb() => kIsWeb;

  /// Returns the current OS.
  static OSType getOS() {
    if (kIsWeb) return OSType.web;
    if (Platform.isAndroid) return OSType.android;
    if (Platform.isIOS) return OSType.iOS;
    if (Platform.isWindows) return OSType.windows;
    if (Platform.isMacOS) return OSType.macOS;
    if (Platform.isLinux) return OSType.linux;
    if (Platform.isFuchsia) return OSType.fuchsia;
    return OSType.unknown;
  }

  @override
  Widget build(BuildContext context) {
    const dummy = SizedBox(height: 0, width: 0);
    switch (getOS()) {
      case OSType.android:
        return android ?? dummy;
      case OSType.iOS:
        return iOS ?? dummy;
      case OSType.windows:
        return windows ?? dummy;
      case OSType.macOS:
        return macOS ?? dummy;
      case OSType.linux:
        return linux ?? dummy;
      case OSType.fuchsia:
        return fuchsia ?? dummy;
      case OSType.web:
        return web ?? dummy;
      case OSType.unknown:
        return unknown ?? dummy;
    }
  }
}

/// OSType is a enum class that helps you to identify the current OS.
enum OSType { android, iOS, windows, macOS, linux, fuchsia, web, unknown }
