import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

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
                SizedBox(
                  width: 400,
                  child: ElevatedButtonWidget(
                    title: 'Lihat status pengajuan',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MentorHomePage(
                                    key:
                                        UniqueKey(), // Jika diperlukan, Anda dapat memberikan kunci unik untuk memastikan widget yang dirender adalah baru
                                    selectedMenu:
                                        'Class', // Tetapkan nilai _selectedMenu ke 'Class'
                                  )),
                          (route) => false);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
