import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkUtils {
  static late StreamSubscription connectivitySubscription;
  static late ConnectivityResult connectivityResult;
  static void init() async {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityResult = result;
    });
  }

  static void dispose() {
    connectivitySubscription.cancel();
  }

  static bool networkConnected() {
    return connectivityResult != ConnectivityResult.none;
  }

  static bool networkAccessible() {
    return networkConnected();
  }

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
