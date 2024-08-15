import 'package:flutter/material.dart';
import 'package:mentormatch_apps/login/login_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class SplashScreenFourth extends StatefulWidget {
  SplashScreenFourth({Key? key}) : super(key: key);

  @override
  State<SplashScreenFourth> createState() => _SplashScreenFourthState();
}

class _SplashScreenFourthState extends State<SplashScreenFourth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      //warnanya dwngan #E37517
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/splashscreen_3.png',
                      //mediaQuery untuk mengambil ukuran layar
                      width: MediaQuery.of(context).size.width * 0.7,
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
                          'Bagikan Keahlian Anda!',
                          style: FontFamily().titleText.copyWith(
                                color: ColorStyle().secondaryColors,
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                            'Kamu juga dapat menjadi mentor bagi\norang lain untuk membagikan pengetahuanmu',
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
                        Size(MediaQuery.of(context).size.width * 0.35, 50),
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginScreen(),
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
                    child: Text(
                      'Get Started',
                      style: FontFamily().buttonText.copyWith(
                            color: ColorStyle().whiteColors,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
