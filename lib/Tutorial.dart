import 'package:flutter/material.dart';

class TutorialRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black),
          Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/tutorial2.png',
                  fit: BoxFit.fitWidth)),
          Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.5),
                end: FractionalOffset(1.0, 1.0),
                colors: [
                  Color.fromRGBO(245, 213, 71, 0.0),
                  Color.fromRGBO(245, 213, 71, 1)
                ]),
          ))
        ],
      ),
    );
  }
}
