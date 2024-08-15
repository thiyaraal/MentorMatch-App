import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/Mentor/Screens/create_class_and_session/create_class/persetujuan_create_class_mentor.dart';
import 'package:my_flutter_app/Mentor/Screens/create_class_and_session/create_session/form_create_session.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class DashboardMentor extends StatefulWidget {
  const DashboardMentor({super.key});

  @override
  State<DashboardMentor> createState() => _DashboardMentorState();
}

class _DashboardMentorState extends State<DashboardMentor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jelajahi Dunia Mentoring\nyang Menginspirasi",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tingkatkan karier Anda dengan membagikan\nkisah sukses dan tantangan pribadi Anda! Buat\nkelas premium yang unik dan memberikan\ninspirasi langsung kepada peserta.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorStyle().disableColors),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButtonWidget(
                    title: "Buat Kelas",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersetujuanPremiClassMentor(),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                width: 200,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SizedBox(
                  width: 400,
                  child: Image.asset(
                    'assets/Handoff/community.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SizedBox(
                  width: 400,
                  child: Image.asset(
                    'assets/Handoff/community.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jelajahi Dunia Mentoring\nyang Menginspirasi",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tingkatkan karier Anda dengan membagikan\nkisah sukses dan tantangan pribadi Anda! Buat\nkelas premium yang unik dan memberikan\ninspirasi langsung kepada peserta.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorStyle().disableColors),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButtonWidget(
                    title: "Buat Session",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormCreateSessionScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
