import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';

class TvPage extends BasePage {
  const TvPage({Key? key}) : super(key: key);

  static const String routerName = "/tv";

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends BasePageState<TvPage> {
  @override
  void init() {}

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold();
  }
}
