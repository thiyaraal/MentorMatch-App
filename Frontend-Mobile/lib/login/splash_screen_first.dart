import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login/splash_screen_second.dart';

class SplashScreenfirst extends StatefulWidget {
  SplashScreenfirst({Key? key}) : super(key: key);

  @override
  State<SplashScreenfirst> createState() => _SplashScreenfirstState();
}

class _SplashScreenfirstState extends State<SplashScreenfirst> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreenSec()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F1F1),
      ),
      backgroundColor: Color(0xFFF8F1F1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo mentirmatch.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
