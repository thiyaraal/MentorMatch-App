import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login/splash_screen_fourth.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class SplashScreenThrid extends StatefulWidget {
  SplashScreenThrid({Key? key}) : super(key: key);

  @override
  State<SplashScreenThrid> createState() => _SplashScreenThridState();
}

class _SplashScreenThridState extends State<SplashScreenThrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      //warnanya dwngan #E37517
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                //navigator push and remove until tanpa animasi
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SplashScreenFourth()),
                    (route) => false);
              },
              child: Text(
                'Skip',
                style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors,
                      fontSize: 18,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/splashscreen_2.jpg',
                    //mediaQuery untuk mengambil ukuran layar
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Mulai Perjalanan Belajarmu!',
                        style: FontFamily().titleText.copyWith(
                              color: ColorStyle().secondaryColors,
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                          'Temukan mentor terbaik yang dapat membantu\nkamu dalam belajar',
                          textAlign: TextAlign.center,
                          style: FontFamily().regularText),
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      ColorStyle().primaryColors,
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.20, 50),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SplashScreenFourth(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: FontFamily().buttonText.copyWith(
                              color: ColorStyle().whiteColors,
                            ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.arrow_forward,
                        color: ColorStyle().whiteColors,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
