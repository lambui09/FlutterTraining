import 'package:flutter/material.dart';

class NavigateUtils {
  static void pushNamed(BuildContext context, String routeName,
      {Object? arguments, bool rootNavigator = false}) {

    Navigator.of(context, rootNavigator: rootNavigator)
        .pushNamed(routeName, arguments: arguments);
  }

  static void pushNamedToRoot(BuildContext context, String routeName,
      [Object? arguments]) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
}
