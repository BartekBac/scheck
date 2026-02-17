import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ShapeStyler {
  DialogShape,
  ButtonShape,
  FieldShape,
  InnerFieldShape,
  InputShape,
}

extension ShapeStylerExtension on ShapeStyler {
  static double _dialogRadius = 15;
  static double _buttonRadius = 4;
  static double _fieldRadius = 12;
  static double _innerFieldRadius = 8;

  OutlinedBorder get outlinedBorder => RoundedRectangleBorder(borderRadius: borderRadius);

  InputBorder get inputBorder => OutlineInputBorder(borderRadius: borderRadius);

  Radius get radius {
    switch(this) {
      case ShapeStyler.DialogShape:
        return Radius.circular(_dialogRadius);
      case ShapeStyler.ButtonShape:
        return Radius.circular(_buttonRadius);
      case ShapeStyler.FieldShape:
      case ShapeStyler.InputShape:
        return Radius.circular(_fieldRadius);
      case ShapeStyler.InnerFieldShape:
        return Radius.circular(_innerFieldRadius);
    }
  }

  BorderRadius get borderRadius => BorderRadius.all(radius);
}
