import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigateUtils {

  static void pushActivity(BuildContext context, StatelessWidget widget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => widget);
    Navigator.push(context, route);
  }

}