import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class SuccesCreateClassScreen extends StatefulWidget {
  SuccesCreateClassScreen({Key? key}) : super(key: key);

  @override
  State<SuccesCreateClassScreen> createState() =>
      _SuccesCreateClassScreenState();
}

class _SuccesCreateClassScreenState extends State<SuccesCreateClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/Handoff/ilustrator/verification.png'),
                Text(
                  'Pengajuan Kelas telah Dikirim ',
                  style: FontFamily().boldText.copyWith(
                        fontSize: 16,
                        color: ColorStyle().succesColors,
                      ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Tunggu sebentar, kelas sedang dalam proses pengajuan. Kami akan memberi tahu Anda begitu kelas tersedia. Terima kasih atas kesabaran Anda.",
                  style: FontFamily().regularText,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButtonWidget(
                  title: 'Lihat status pengajuan',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavbarMentorScreen(
                                  activeScreen: 1,
                                )),
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
