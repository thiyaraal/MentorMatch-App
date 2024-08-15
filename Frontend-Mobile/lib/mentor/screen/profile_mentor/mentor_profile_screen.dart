import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentormatch_apps/login/login_screen.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/profile_mentor/edit_profile_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/mentor/service/profile_service.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/show_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/profile_model.dart';

class MentorProfileScreen extends StatefulWidget {
  const MentorProfileScreen({super.key});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationsCount = 0;

  Future<void> _fetchUnreadNotificationsCount() async {
    try {
      final notifications =
          await _notificationService.fetchNotificationsForCurrentUser();
      final unreadCount =
          notifications.where((notification) => !notification.isRead!).length;
      setState(() {
        _unreadNotificationsCount = unreadCount;
      });
    } catch (e) {
      print(e); // Handle error appropriately
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka $urlString';
      }
    } catch (e) {
      throw 'URL tidak valid: $urlString';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _fetchUnreadNotificationsCount();
  }

  void _loadData() async {
    final profileData = await mentorService.getMentorProfile();
    setState(() {});
  }

  final ProfileService mentorService = ProfileService();

  void _navigateToEditProfile() async {
    final mentor = await mentorService
        .getMentorProfile(); // Assuming you fetch the mentor profile here

    if (!mounted) return; // Check if the widget is still in the widget tree

    if (mentor != null && mentor.user != null) {
      List<Map<String, String>> experiencesMaps = mentor.user!.experiences!
          .where((experience) =>
              experience.isCurrentJob ==
              false) // Filter experiences where isCurrentJob is false
          .map((experience) => {
                "jobTitle": experience.jobTitle ?? '',

                "company": experience.company ?? '',
                // Add other fields as necessary
              })
          .toList();

      // Navigate to EditProfileMentorScreen with the converted experiences
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileMentorScreen(
            linkedin: mentor.user!.linkedin ?? '',
            about: mentor.user!.about ?? '',
            location: mentor.user!.location ?? '',
            currentJob: mentor.user!.experiences
                    ?.firstWhere((element) => element.isCurrentJob == true,
                        orElse: () => ExperienceMentor())
                    .jobTitle ??
                '',
            currentCompany: mentor.user!.experiences
                    ?.firstWhere((element) => element.isCurrentJob == true,
                        orElse: () => ExperienceMentor())
                    .company ??
                '',
            experiences: experiencesMaps,
            skills: mentor.user!.skills ?? [],
          ),
        ),
      );
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await UserPreferences.clearPreferences();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Sign out failed: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/Handoff/logo/LogoMobile.png',
              width: 120,
              height: 120,
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationMentorScreen(),
                      ),
                    ).then((_) {
                      _fetchUnreadNotificationsCount(); // Fetch the unread count when returning to this screen
                    });
                  },
                  icon: Icon(Icons.notifications_none_outlined),
                  color: ColorStyle().secondaryColors,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$_unreadNotificationsCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
      body: FutureBuilder<MentorProfile>(
        future: mentorService
            .getMentorProfile(), // Call the asynchronous fetchMentee method here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final mentor = snapshot.data;

            return ListView(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/Handoff/ilustrator/background.png',
                      width: double.maxFinite,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    Transform.translate(
                      offset: Offset(0.0, -120 / 2.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileAvatar(
                              imageUrl: mentor!.user?.photoUrl,
                            ),
                            SizedBox(
                              height: 40,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      mentor.user?.name ?? '',
                                      style: FontFamily().boldText.copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      top:
                                          0, // Adjust as needed to position the edit icon correctly
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed:
                                            _navigateToEditProfile, // Use the method to navigate
                                      )),
                                ],
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // This ensures the Row only takes up necessary space
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Provides a small gap between the icon and the text
                                  Text(
                                    "${mentor.user?.experiences?.firstWhere((element) => element.isCurrentJob == true).jobTitle ?? ""} at ${mentor.user?.experiences?.firstWhere((element) => element.isCurrentJob == true).company ?? ""}",
                                    style: FontFamily().regularText,
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // This ensures the Row only takes up necessary space
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Provides a small gap between the icon and the text
                                  Text(
                                    mentor.user?.location ?? '',
                                    style: FontFamily().regularText,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleProfile(
                                  title: "About",
                                  color: ColorStyle().primaryColors,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    mentor.user?.about ?? '',
                                    style: FontFamily().regularText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12.0, top: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: ColorStyle().primaryColors,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              ColorStyle().whiteColors,
                                        ),
                                        onPressed: () {
                                          final linkedlnlink =
                                              mentor?.user!.linkedin ?? '';
                                          _launchURL(linkedlnlink);
                                        },
                                        icon: Icon(Icons.link),
                                        label: Text('Linkedln',
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                  color:
                                                      ColorStyle().whiteColors,
                                                )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleProfile(
                                  title: 'Experience',
                                  color: ColorStyle().primaryColors,
                                ),
                                Column(
                                  children: mentor.user!.experiences
                                          ?.where((experience) =>
                                              experience.isCurrentJob == false)
                                          .map((experience) {
                                        return ExperienceWidget(
                                          role: experience.jobTitle ??
                                              'No Job Title',
                                          company: experience.company ??
                                              'No Company',
                                        );
                                      }).toList() ??
                                      [Text('No experiences')],
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TitleProfile(
                                title: 'Skills',
                                color: ColorStyle().primaryColors,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: mentor.user!.skills
                                            ?.map((skill) => SkillCard(
                                                  skill: skill,
                                                ))
                                            .toList() ??
                                        [Text('No skills')]),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomConfirmationDialog(
                                        aksi: 'Keluar',
                                        aksi2: 'Batal',
                                        title: "Konfirmasi",
                                        content:
                                            "Apakah kamu yakin ingin keluar dari aplikasi MentorMatch?",
                                        onConfirm: () async {
                                          await _handleSignOut();
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.logout,
                                    color: ColorStyle().secondaryColors),
                                label: Text(
                                  'Logout',
                                  style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().secondaryColors),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
