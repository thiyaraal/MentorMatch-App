import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentormatch_apps/fcm_service.dart';
import 'package:mentormatch_apps/login/choose_role_screen.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/verification_regist.dart';
import 'package:mentormatch_apps/mentor/service/login_service.dart';
import 'package:mentormatch_apps/widget/button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggingIn = false;

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
          // Mengambil ID token dari Firebase Auth
          String? idToken = await user.getIdToken();
          print('ID Token: $idToken');

          // Membuat instance AuthService dan memanggil loginUser
          AuthService authService = AuthService();
          await authService.loginUser(idToken!);

          // Cek data yang disimpan di SharedPreferences
          Map<String, String?> userData = await AuthService.getUserData();

          if (!Platform.isIOS) {
            String? fcmToken = await FirebaseMessaging.instance.getToken();
            if (fcmToken != null && userData['userId'] != null) {
              await sendTokenToServer(fcmToken, userData['userId']!);
            }
          }
          // Tentukan navigasi berdasarkan userType
          String? userType = userData['userType'];
          if (userType == null) {
            // Jika userType belum ada atau null, navigasi ke ChooseRoleScreen
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ChooseRoleScreen()));
          } else {
            // Jika userType ada, navigasi ke halaman yang sesuai berdasarkan userType
            // Contoh:
            if (userType == "Mentee") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BottomNavbarMenteeScreen()));
            } else if (userType == "Mentor") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BottomNavbarMentorScreen()));
              // Tambahkan kondisi untuk userType PendingMentor atau RejectedMentor
            } else if (userType == "PendingMentor" ||
                userType == "RejectedMentor") {
              // Navigasi ke halaman verifikasi mentor
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => VerificationFormRegistScreen()));
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
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/Handoff/logo/LogoMobile.png'),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/Handoff/ilustrator/first screen.png'),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selamat Datang di Aplikasi Mentor Terbaik',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0A1737),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Dengan Mentormatch, Anda dapat terhubung dengan mentor yang berpengalaman dan inspiratif di berbagai bidang.',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButtonWidget(
                      onPressed: _isLoggingIn
                          ? null
                          : () async {
                              await signInWithGoogle();
                            },
                      title: "Login with Google Account",
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoggingIn)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
