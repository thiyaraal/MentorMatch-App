import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syarat_ketentuan_daftar_mentor/registrasi_ulang_mentor.dart';
import 'package:mentormatch_apps/mentor/service/profile_service.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class VerificationFormRegistScreen extends StatefulWidget {
  VerificationFormRegistScreen({Key? key}) : super(key: key);

  @override
  State<VerificationFormRegistScreen> createState() =>
      _VerificationFormRegistScreenState();
}

class _VerificationFormRegistScreenState
    extends State<VerificationFormRegistScreen> {
  final ProfileService mentorService = ProfileService();
  bool isLoading = true;
  String _userType = '';
  String _rejectReason = '';

  @override
  void initState() {
    super.initState();
    _loadUserType();
  }

  void _loadUserType() async {
    final profileData = await mentorService.getMentorProfile();
    setState(() {
      isLoading = false;
      _userType = profileData.user?.userType ?? 'Unknown';
      _rejectReason = profileData.user?.rejectReason ?? '';
    });

    if (_userType == 'Mentor') {
      await UserPreferences.setUserType(
          _userType); // Update the user type in preferences
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavbarMentorScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Handoff/logo/LogoMobile.png'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset('assets/Handoff/ilustrator/verification.png'),
              const SizedBox(height: 12),
              Text(
                'Terima kasih telah mendaftar sebagai mentor di MentorMatch. ',
                style: FontFamily().titleText.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              isLoading
                  ? CircularProgressIndicator()
                  : _userType == 'PendingMentor'
                      ? Column(
                          children: [
                            Text(
                              'Akun Anda masih dalam proses verifikasi.',
                              style: FontFamily().regularText,
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                    _loadUserType();
                                  });
                                },
                                child: Text("Refresh")),
                          ],
                        )
                      : _userType == 'RejectedMentor'
                          ? Column(
                              children: [
                                Text(
                                  'Akun Anda ditolak.',
                                  style: FontFamily().regularText,
                                  textAlign: TextAlign.center,
                                ),
                                if (_rejectReason.isNotEmpty)
                                  Text(
                                    'Alasan Penolakan: $_rejectReason',
                                    style: FontFamily().regularText,
                                    textAlign: TextAlign.center,
                                  ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate ke RegisterUlangMentorScreen
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterUlangMentorScreen()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text('Kirim Ulang Verifikasi'),
                                ),
                              ],
                            )
                          : Text(
                              'Status verifikasi tidak diketahui.',
                              style: FontFamily().regularText,
                              textAlign: TextAlign.center,
                            ),
            ],
          )
        ],
      ),
    );
  }
}
