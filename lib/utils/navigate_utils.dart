import 'package:flutter/material.dart';

class NavigateUtils {
  static void pushNamed(BuildContext context, String routeName,
      [Object? arguments]) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pushNamedToRoot(BuildContext context, String routeName,
      [Object? arguments]) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
}
