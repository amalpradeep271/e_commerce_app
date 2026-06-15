import 'package:flutter/material.dart';

class AppNavigator {

  static Future<dynamic> pushReplacement(BuildContext context,Widget widget) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget)
    );
  }

  static Future<dynamic> push(BuildContext context,Widget widget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget)
    );
  }

  static Future<dynamic> pushAndRemove(BuildContext context,Widget widget) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false
    );
  }
}