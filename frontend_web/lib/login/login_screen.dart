// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/admin/screen/dasboard_admin_screen.dart';
import 'package:my_flutter_app/login/choose_role_screen.dart';
import 'package:my_flutter_app/login/login_service.dart';
import 'package:my_flutter_app/mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/mentor/Screens/homepage_mentor.dart';
import 'package:my_flutter_app/mentor/screens/register_mentor/verification_page.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    // GoogleSignIn().onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {});
    // });
    // GoogleSignIn().signInSilently();
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoggingIn = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          String? idToken = await user.getIdToken();
          print('ID Token: $idToken');

          AuthService authService = AuthService();
          await authService.loginUser(idToken!);

          Map<String, String?> userData = await AuthService.getUserData();

          String? userType = userData['userType'];
          if (userType == null || userType.isEmpty) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const ChooseRoleScreen()));
          } else {
            if (userType == "Mentee") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MenteeHomePage()));
            } else if (userType == "Mentor") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MentorHomePage()));
            } else if (userType == "Admin") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DashboardAdminScreen()));
            } else if (userType == "PendingMentor" ||
                userType == "RejectedMentor") {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => VerificationPage()));
            }
          }
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login failed: $e"),
        ),
      );
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/Handoff/logo/LogoWeb.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daftar untuk memulai Mentorship',
                                style: GoogleFonts.poppins(
                                    fontSize: 40, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                'Mari lanjutkan langkah untuk dunia pendidikan yang lebih baik dengan sesio mentoring bersama mentor-mentor ahli yang dapat membantu kamu dalam mencapai target dan tujuan.',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: ColorStyle().disableColors,
                                ),
                              ),
                              const SizedBox(height: 50),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: ElevatedButton(
                                  onPressed: _isLoggingIn
                                      ? null
                                      : () async {
                                          await signInWithGoogle();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE78839),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 125, vertical: 35),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  child: Text(
                                    'Login with Google',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              width: 42.12,
                              child: Image.asset(
                                'assets/Handoff/ilustrator/login.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoggingIn)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
