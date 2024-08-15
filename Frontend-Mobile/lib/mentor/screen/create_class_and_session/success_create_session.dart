import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class SuccesCreateSessionScreen extends StatefulWidget {
  SuccesCreateSessionScreen({Key? key}) : super(key: key);

  @override
  State<SuccesCreateSessionScreen> createState() =>
      _SuccesCreateSessionScreenState();
}

class _SuccesCreateSessionScreenState extends State<SuccesCreateSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/Handoff/ilustrator/verification.png'),
                Text(
                  'Session Berhasil dibuat',
                  style: FontFamily().boldText.copyWith(
                        fontSize: 16,
                        color: ColorStyle().succesColors,
                      ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Selamat, session kamu baru saja berhasil kamu buat, silahkan liat menu Myclass untuk melihat list session yang kamu punya",
                  style: FontFamily().regularText,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButtonWidget(
                  title: 'Kembali ke Beranda',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavbarMentorScreen()),
                        (route) => false);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
