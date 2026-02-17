import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/shape_styler.dart';

class ErrorHandler {
  static void showAtSnackBar(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("$error"),
          duration: Duration(seconds: 5),
          showCloseIcon: true,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          behavior: SnackBarBehavior.floating,
          shape: ShapeStyler.DialogShape.outlinedBorder
      ),
    );
  }
}