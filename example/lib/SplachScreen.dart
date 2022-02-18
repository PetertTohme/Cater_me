
import 'package:CaterMe/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    // _controller = AnimationController(
    //   duration: Duration(seconds: (2)),
    //   vsync: this,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Lottie.asset(
        'images/animation/LottieCaterMe.json',
       // controller: _controller,
     //   height: MediaQuery.of(context).size.height * 5,

      //  animate: true,

      ),
    );
  }
}