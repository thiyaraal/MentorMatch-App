import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/login/choose_role_service.dart';
import 'package:my_flutter_app/mentee/screen/profile/edit_profile_mentee_screen.dart';
import 'package:my_flutter_app/mentor/Screens/register_mentor/persetujuan_mentor_screen.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  final ChooseRoleService chooseRoleService = ChooseRoleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Image.asset(
                  'assets/Handoff/logo/LogoWeb.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your Role',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: const Color(0xff0A1737),
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Ingin memberi panduan sebagai mentor atau mendapatkan bimbingan sebagai mentee? Sebagai mentor, Anda bisa berbagi pengalaman dan inspirasi. Sebagai mentee, Anda dapat belajar dari yang lebih berpengalaman',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: const Color(0xff0A1737),
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 400,
                  height: 700,
                  decoration: BoxDecoration(
                    color: ColorStyle().whiteColors,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            color: ColorStyle().tertiaryColors,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Handoff/ilustrator/mentor_role.png',
                                  width: 265,
                                  height: 265,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Mentor',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Seorang mentor adalah individu yang memiliki pengetahuan, pengalaman, dan keahlian dalam suatu bidang tertentu, serta bersedia untuk berbagi pengetahuan dan memberikan bimbingan kepada orang lain yang ingin belajar dan berkembang.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorStyle().primaryColors)),
                          onPressed: () async {
                            // Assuming you have an instance of AuthService
                            // await chooseRoleService.chooseRole("Mentor");

                            if (mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PersetujuanMentorScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          child: Text(
                            'As a Mentor',
                            style: FontFamily().buttonText.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 400,
                  height: 700,
                  decoration: BoxDecoration(
                    color: ColorStyle().whiteColors,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            color: ColorStyle().tertiaryColors,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Handoff/ilustrator/mentee_role.png',
                                  width: 265,
                                  height: 265,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Mentee',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Seorang mentee adalah individu yang aktif mencari bimbingan dan nasihat dari seorang mentor untuk mengembangkan diri pribadi atau profesional.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorStyle().primaryColors)),
                            onPressed: () async {
                              // Start the async operation
                              // await chooseRoleService.chooseRole("Mentee");

                              if (mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileMenteeScreen(
                                      skills: [],
                                      linkedin: '',
                                      about: '',
                                      location: '',
                                      currentJob: '',
                                      currentCompany: '',
                                      experiences: [],
                                      selectedMenu: 'Dashboard',
                                      selectedRole: 'Mentee',
                                    ),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            child: Text(
                              'As a Mentee',
                              style: FontFamily().buttonText.copyWith(
                                    fontSize: 14,
                                  ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
            //
          ],
        ),
      )),
    );
  }
}
