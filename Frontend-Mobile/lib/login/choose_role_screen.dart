import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentormatch_apps/mentee/screen/profile/edit_profile_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syarat_ketentuan_daftar_mentor/persetujuan_rekening.dart';
import 'package:mentormatch_apps/mentor/service/choose_role_service.dart';
import 'package:mentormatch_apps/widget/button.dart';

class ChooseRoleScreen extends StatefulWidget {
  ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  final ChooseRoleService chooseRoleService = ChooseRoleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/Handoff/ilustrator/choose role.png'),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          'Choose Role',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0A1737),
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Ingin memberi panduan sebagai mentor atau mendapatkan bimbingan sebagai mentee? Sebagai mentor, Anda bisa berbagi pengalaman dan inspirasi. Sebagai mentee, Anda dapat belajar dari yang lebih berpengalaman',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButtonWidget(
                                onPressed: () async {
                                  // Start the async operation
                                  // await chooseRoleService.chooseRole("Mentee");

                                  // Check if the widget is still mounted before using the context
                                  if (mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileMenteeScreen(
                                          activeScreen: 0,
                                          skills: [],
                                          linkedin: '',
                                          about: '',
                                          location: '',
                                          currentJob: '',
                                          currentCompany: '',
                                          experiences: [],
                                          selectedRole: 'Mentee',
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                                title: "As a Mentee",
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    'or',
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              ElevatedButtonWidget(
                                onPressed: () async {
                                  // Check if the widget is still mounted before using the context
                                  if (mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PersetujuanRekeningScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                                title: "As a Mentor",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
