import 'package:flutter/material.dart' show Color;
import 'package:fluttertoast/fluttertoast.dart';

enum HiveBoxName{
  inventoryBox("inventory"),
  compositionBox("compositions");

  final String name;
  const HiveBoxName(this.name);
}
enum HiveKeys{
  inventoryKey("inventoryKey"),
  compositionKey("compositionsKey");

  final String name;
  const HiveKeys(this.name);
}

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
