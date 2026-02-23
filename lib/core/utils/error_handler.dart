import 'package:flutter/material.dart';
import 'package:scheck/core/stylers/color_styler.dart';
import 'package:scheck/core/utils/dialog_handler.dart';

class ErrorHandler {
  static void showAtSnackBar(BuildContext context, Object error, {bool immediate = false}) {
    DialogHandler.showSnackBar(context,
        message: error.toString(),
        backgroundColor: ColorStyler.Error.color(context),
        immediate: immediate
    );
  }
}