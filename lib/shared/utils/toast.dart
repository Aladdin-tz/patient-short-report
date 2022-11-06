import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilities {
  static showToast(String message, {length, gravity, color, textColor}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length ?? Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM,
        backgroundColor: color ?? Colors.black54,
        textColor: textColor ?? Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
