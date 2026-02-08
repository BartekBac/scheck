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
}