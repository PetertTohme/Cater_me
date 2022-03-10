import 'dart:async';

import 'package:CaterMe/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (1)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 7000),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => appstate(),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Image.asset(
        "images/animation/CaterMeNewGif.gif",
         height: MediaQuery.of(context).size.height * 0.60,
         width: MediaQuery.of(context).size.width * 0.7,
      )),
    );
  }
}
