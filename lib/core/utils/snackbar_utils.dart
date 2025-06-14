import 'package:flutter/material.dart';

class SnackbarUtils {
  const SnackbarUtils._();

  static void showError(BuildContext context, String message) {
    _showSnackbar(context, message, color: Colors.red);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(context, message, color: Colors.green);
  }

  static void _showSnackbar(
    BuildContext context,
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
