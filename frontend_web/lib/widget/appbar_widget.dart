import 'package:flutter/material.dart';

class AppBarLandingPageWidget extends StatefulWidget {
  AppBarLandingPageWidget({Key? key}) : super(key: key);

  @override
  State<AppBarLandingPageWidget> createState() =>
      _AppBarLandingPageWidgetState();
}

class _AppBarLandingPageWidgetState extends State<AppBarLandingPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/logo-1.png',
          height: 150,
          width: 150,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}


