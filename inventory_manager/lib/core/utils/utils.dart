import 'package:flutter/material.dart' show Color;
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(
  String message, {
  Color? backgroundColor,
  Color? textColor,
  double? fontSize,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize ?? 15.0,
  );
}
