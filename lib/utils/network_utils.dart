import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkUtils {
  /// Stream of connectivity status.
  static late StreamSubscription connectivitySubscription;
  /// Current network status
  static late ConnectivityResult connectivityResult;

  /// Initialize network utils
  static void init() async {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityResult = result;
    });
  }

  /// Stop listening to connectivity changes
  static void dispose() {
    connectivitySubscription.cancel();
  }

  /// Check if there is internet connection
  static bool networkConnected() {
    return connectivityResult != ConnectivityResult.none;
  }

  /// Check if the internet connection is accessible
  static bool networkAccessible() {
    return networkConnected();
  }

  /// Show a message when there is no internet connection
  static showNetworkAccessDeniedMessage({
    String? notConnectedMessage,
    String? notAccessibleMessage,
  }) {
    if (!networkConnected()) {
      Fluttertoast.showToast(
        msg: notConnectedMessage ?? "No internet connection",
      );
    } else if (!networkAccessible()) {
      Fluttertoast.showToast(
        msg: notAccessibleMessage ?? "No internet access",
      );
    }
  }
}
