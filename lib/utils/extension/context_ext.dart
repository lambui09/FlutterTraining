import 'package:flutter/material.dart';

extension BuildContextSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get width => screenSize.width;

  double get height => screenSize.height;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}
