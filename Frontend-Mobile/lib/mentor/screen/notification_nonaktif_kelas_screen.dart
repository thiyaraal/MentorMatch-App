import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class NonAktifKelasScreen extends StatefulWidget {
  NonAktifKelasScreen({Key? key}) : super(key: key);

  @override
  State<NonAktifKelasScreen> createState() => _NonAktifKelasScreenState();
}

class _NonAktifKelasScreenState extends State<NonAktifKelasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nonaktif Kelas',
          style: FontFamily().titleText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset("assets/Handoff/ilustrator/question.png"),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                    textAlign: TextAlign.center,
                    "Kamu dapat menyelesaiakan program ini apabila periode premium class yang kamu ikuti telah selesai dilakukan sesuai dengan jadwal yang tersedia. Apabila kamu menonaktifkan kelas ini maka kamu dan mentee tidak dapat melanjutkan kelas ini.",
                    style: FontFamily().regularText),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmallOutlinedButton(
                    height: 32,
                    width: 120,
                    title: "Batal",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().primaryColors,
                        ),
                    onPressed: () {
                      // Gantikan halaman saat ini dengan BottomNavbarScreen
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             DetailMyClassMentorScreen()));
                    },
                  ),
                  SmallElevatedButton(
                    height: 32,
                    width: 120,
                    title: "Nonaktifkan",
                    style: FontFamily().buttonText.copyWith(
                          fontSize: 12,
                          color: ColorStyle().whiteColors,
                        ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavbarMentorScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
