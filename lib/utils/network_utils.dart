import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkUtils {
  /// Stream of connectivity status.
  static late StreamSubscription connectivitySubscription;

  /// Current network status
  static late ConnectivityResult connectivityResult;

  /// Minimum network level
  static late ConnectivityResult minimum;

  /// Initialize network utils
  static Future<void> init(ConnectivityResult minimumNetworkLevel) async {
    minimum = minimumNetworkLevel;
    connectivitySubscription = Connectivity()
        .onConnectivityChanged.listen((event) { });
    connectivitySubscription.onData((data) {
      connectivityResult = data;
    });
    connectivityResult = await Connectivity().checkConnectivity();
  }

  /// Set minimum network level
  static void setMinimumNetworkLevel(ConnectivityResult minimumNetworkLevel) {
    minimum = minimumNetworkLevel;
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
    return networkConnected() && connectivityResult.index <= minimum.index;
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
