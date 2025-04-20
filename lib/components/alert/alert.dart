import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage(
    {required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 10)}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: duration,
      action: SnackBarAction(
          label: "Close", onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      backgroundColor: Colors.red,
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessMessage(
    {required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 5)}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: duration,
      action: SnackBarAction(
          label: "Close", onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      backgroundColor: Colors.green,
    ),
  );
}
