import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';

class NavigateUtils {
  static void pushActivity(BuildContext context, BasePage widget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => widget);
    Navigator.of(context).push(route);
  }

  static void popActivity(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushToRootActivity(BuildContext context, BasePage widget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => widget);
    Navigator.of(context).pushReplacement(route);
  }
}
