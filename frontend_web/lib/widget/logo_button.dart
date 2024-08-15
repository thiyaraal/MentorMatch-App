import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';

class ButtonLogoMentorMatch extends StatefulWidget {
  ButtonLogoMentorMatch({Key? key}) : super(key: key);

  @override
  State<ButtonLogoMentorMatch> createState() => _ButtonLogoMentorMatchState();
}

class _ButtonLogoMentorMatchState extends State<ButtonLogoMentorMatch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman yang diinginkan saat gambar diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MentorHomePage(), // Ganti HalamanTujuan dengan nama halaman yang diinginkan
          ),
        );
      },
      child: Image.asset('assets/Handoff/logo/LogoMobile.png'),
    );
  }
}


class ButtonLogoMenteeMatch extends StatefulWidget {
  ButtonLogoMenteeMatch({Key? key}) : super(key: key);

  @override
  State<ButtonLogoMenteeMatch> createState() => _ButtonLogoMenteeMatchState();
}

class _ButtonLogoMenteeMatchState extends State<ButtonLogoMenteeMatch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman yang diinginkan saat gambar diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MenteeHomePage(), // Ganti HalamanTujuan dengan nama halaman yang diinginkan
          ),
        );
      },
      child: Image.asset('assets/Handoff/logo/LogoMobile.png'),
    );
  }
}