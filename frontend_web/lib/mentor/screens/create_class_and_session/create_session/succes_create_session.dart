import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButtonWidget(
                  title: 'Lihat Session',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MentorHomePage(
                          selectedMenu: "Class",
                          subMenu:
                              "My Session", // New parameter to indicate sub-menu selection
                        ),
                      ),
                    );
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
