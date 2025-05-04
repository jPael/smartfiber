import 'package:flutter/material.dart';

class Alert {
  // Global key for scaffold messenger
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage({
    required String message,
    Duration duration = const Duration(seconds: 10),
  }) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        duration: duration,
        action: SnackBarAction(
          label: "Close",
          onPressed: () => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessMessage({
    required String message,
    Duration duration = const Duration(seconds: 5),
  }) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        duration: duration,
        action: SnackBarAction(
          label: "Close",
          onPressed: () => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
