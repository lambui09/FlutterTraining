import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<T extends BasePage> extends State<T> {

  void init();

  Widget buildUI(BuildContext context);

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return buildUI(context);
  }
}
