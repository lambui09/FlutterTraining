import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/ui/tutorial/tutorial_page.dart';
import 'package:untitled/utils/navigate_utils.dart';

class SplashPage extends BasePage {
  static SplashPage instance() => SplashPage();

  final String screenName = "SplashPage";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage> {

  @override
  void init() {}

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(249, 159, 0, 1),
                  Color.fromRGBO(219, 48, 105, 1)
                ]),
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/background.png',
                  fit: BoxFit.fitWidth)),
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: screenHeight / 3.5),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png',
                      fit: BoxFit.fill, width: screenWidth / 3.5),
                  Padding(padding: const EdgeInsets.only(top: 4)),
                  TextButton(
                      style: TextButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        NavigateUtils.pushToRootActivity(
                            context, TutorialPage.instance());
                      },
                      child: Text('Flutter Training'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white)))
                ],
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                  child: Text('Copyright © 2021',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.white60))))
        ],
      ),
    );
  }
}
