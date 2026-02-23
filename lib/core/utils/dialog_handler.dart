import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/color_styler.dart';

class DialogHandler {

  static Future<bool> showConfirmDialog(BuildContext context, String question) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text(question),
          actions: [
            ElevatedButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false)
            ),
            ElevatedButton(
              child: Text("Confirm"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyler.Primary.color(context),
                foregroundColor: ColorStyler.Primary.onColor(context),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        );
      },
    ) ?? false;
  }

  static void showSnackBar(BuildContext context, {required String message, Color? backgroundColor, bool immediate = false}) {
    backgroundColor ??= ColorStyler.Primary.color(context);
    if(immediate) {
      clearSnackBar(context);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: backgroundColor,

      ),
    );
  }

  static void clearSnackBar(BuildContext context, {bool slow = false, SnackBarClosedReason? reason}) {
    final closedReason = reason ?? SnackBarClosedReason.action;
    if(slow) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: closedReason);
    }
    ScaffoldMessenger.of(context).removeCurrentSnackBar(reason: closedReason);
  }
}