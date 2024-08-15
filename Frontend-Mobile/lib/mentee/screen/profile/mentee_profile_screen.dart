import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentormatch_apps/login/login_screen.dart';
import 'package:mentormatch_apps/mentee/model/profile_model.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/edit_profile_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/service.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/show_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMenteeScreen extends StatefulWidget {
  ProfileMenteeScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMenteeScreen> createState() => _ProfileMenteeScreenState();
}

class _ProfileMenteeScreenState extends State<ProfileMenteeScreen> {
  int _unreadNotificationsCount = 0;
  final NotificationService _notificationService = NotificationService();

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

  final ProfileService menteeService = ProfileService();
  late Future<MenteeProfile> _menteeProfileFuture;

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _menteeProfileFuture = menteeService.getMenteeProfile();
    });
  }

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

  void _navigateToEditProfile() async {
    final mentee = await menteeService
        .getMenteeProfile(); // Assuming you fetch the mentee profile here

    if (!mounted) return; // Check if the widget is still in the widget tree

    if (mentee != null && mentee.user != null) {
      List<Map<String, String>> experiencesMaps = mentee.user!.experiences!
          .where((experience) =>
              experience.isCurrentJob ==
              false) // Filter experiences where isCurrentJob is false
          .map((experience) => {
                "jobTitle": experience.jobTitle ?? '',

                "company": experience.company ?? '',
                // Add other fields as necessary
              })
          .toList();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileMenteeScreen(
            linkedin: mentee.user!.linkedin ?? '',
            about: mentee.user!.about ?? '',
            location: mentee.user!.location ?? '',
            currentJob: mentee.user!.experiences
                    ?.firstWhere((element) => element.isCurrentJob == true,
                        orElse: () => ExperienceMentee())
                    .jobTitle ??
                '',
            currentCompany: mentee.user!.experiences
                    ?.firstWhere((element) => element.isCurrentJob == true,
                        orElse: () => ExperienceMentee())
                    .company ??
                '',
            experiences: experiencesMaps,
            skills: mentee.user!.skills ?? [],
            activeScreen: 3, // Pass 3 for active screen 3
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
        backgroundColor: ColorStyle().whiteColors,
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
                        builder: (context) => NotificationMenteeScreen(),
                      ),
                    ).then((_) {
                      _fetchUnreadNotificationsCount(); // Fetch the unread count when returning to this screen
                    });
                  },
                  icon: const Icon(Icons.notifications_none_outlined),
                  color: ColorStyle().secondaryColors,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$_unreadNotificationsCount',
                        style: const TextStyle(
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
      body: FutureBuilder<MenteeProfile>(
        future: menteeService
            .getMenteeProfile(), // Call the asynchronous fetchMentee method here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final mentee = snapshot.data;

            return ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/Handoff/ilustrator/background.png',
                      width: double.maxFinite,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -120 / 2.0),
                      child: Center(
                        child: Column(
                          children: [
                            ProfileAvatar(
                                // user placeholder image if user does not have a photo
                                imageUrl: mentee?.user?.photoUrl ??
                                    'https://via.placeholder.com/150'),
                            SizedBox(
                              height:
                                  40, // Adjust the height to ensure enough space for the Stack
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      mentee!.user?.name ?? '',
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
                                        icon: const Icon(Icons.edit),
                                        onPressed: _navigateToEditProfile,
                                      )),
                                ],
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Ensures the Row only takes up necessary space
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  const SizedBox(
                                      width:
                                          8), // Provides a small gap between the icon and the text
                                  Text(
                                    "${mentee.user?.experiences?.firstWhere((element) => element.isCurrentJob == true, orElse: () => ExperienceMentee()).jobTitle ?? 'No Job Title'} at ${mentee.user?.experiences?.firstWhere((element) => element.isCurrentJob == true, orElse: () => ExperienceMentee()).company ?? 'No Company'}",
                                    style: FontFamily().regularText,
                                  ),
                                ],
                              ),
                            ),

// For Location Information Row
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // This ensures the Row only takes up necessary space
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: ColorStyle().primaryColors,
                                  ),
                                  const SizedBox(
                                      width:
                                          8), // Provides a small gap between the icon and the text
                                  Text(
                                    mentee.user?.location ?? '',
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
                                    mentee.user?.about ?? '',
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
                                          if (mentee.user!.linkedin == null ||
                                              mentee.user!.linkedin == '') {
                                            showTopSnackBar(context,
                                                'LinkedIn belum diisi');
                                          } else {
                                            _launchURL(
                                                mentee.user!.linkedin ?? '');
                                          }
                                        },
                                        icon: const Icon(Icons.link),
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleProfile(
                                    title: 'Experience',
                                    color: ColorStyle().primaryColors,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if (mentee.user!.experiences
                                          ?.where((experience) =>
                                              experience.isCurrentJob == false)
                                          .toList()
                                          .isEmpty ??
                                      true)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        'no experiences',
                                        style: FontFamily()
                                            .regularText
                                            .copyWith(
                                              fontSize: 14,
                                              color: ColorStyle().disableColors,
                                            ),
                                      ),
                                    )
                                  else
                                    Column(
                                      children: mentee.user!.experiences
                                              ?.where((experience) =>
                                                  experience.isCurrentJob ==
                                                  false)
                                              .map((experience) {
                                            return ExperienceWidget(
                                              role: experience.jobTitle ??
                                                  'No Job Title',
                                              company: experience.company ??
                                                  'No Company',
                                            );
                                          }).toList() ??
                                          [const Text('No experiences')],
                                    )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TitleProfile(
                                title: 'Skills',
                                color: ColorStyle().primaryColors,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: mentee.user!.skills
                                            ?.map((skill) => SkillCard(
                                                  skill: skill,
                                                ))
                                            .toList() ??
                                        [const Text('No skills')]),
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
