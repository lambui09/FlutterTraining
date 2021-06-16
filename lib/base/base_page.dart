import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  double screenWidth = 0;
  double screenHeight = 0;

  void init();

  Widget renderUI(BuildContext context);

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return renderUI(context);
  }
}
