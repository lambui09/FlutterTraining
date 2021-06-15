import 'package:flutter/material.dart';
import 'package:untitled/NavigateUtils.dart';
import 'package:untitled/Tutorial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                        NavigateUtils.pushActivity(context, TutorialRoute());
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
