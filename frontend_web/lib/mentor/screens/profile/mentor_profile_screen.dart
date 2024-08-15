import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentor/model/profile_model.dart';
import 'package:my_flutter_app/mentor/screens/notification_mentor_screen.dart';
import 'package:my_flutter_app/mentor/screens/profile/edit_profile_mentor_screen.dart';
import 'package:my_flutter_app/mentor/service/notification_service.dart';
import 'package:my_flutter_app/mentor/service/profile_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/logo_button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/profileavatar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMentorScreen extends StatefulWidget {
  ProfileMentorScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMentorScreen> createState() => _ProfileMentorScreenState();
}

class _ProfileMentorScreenState extends State<ProfileMentorScreen> {
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
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
    final mentor = await mentorService.getMentorProfile();

    if (!mounted) return;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonLogoMentorMatch(),
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
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                  ),
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
            ),
          ],
        ),
      ),
      body: FutureBuilder<MentorProfile>(
        future: mentorService.getMentorProfile(),
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
            final mentor = snapshot.data;

            return ListView(
              children: [
                Image.asset(
                  'assets/Handoff/ilustrator/backgroud.png',
                  width: double.maxFinite,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFf8f0f0), // #F8F0F0
                        Colors.white,
                      ],
                      stops: [0.5, 0.5],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 50,
                      right: 50,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileAvatar(
                          imageUrl: mentor?.user!.photoUrl ?? '',
                          radius: 80,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    mentor?.user!.name ?? '',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color:
                                          Colors.black, // Text color adjusted
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: _navigateToEditProfile,
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.work_outline_outlined,
                                        size: 20,
                                        color: Color(0xffE78938),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        mentor?.user!.experiences!
                                                .firstWhere((element) =>
                                                    element.isCurrentJob ==
                                                    true)
                                                .jobTitle ??
                                            '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 20,
                                          color: Color(0xffE78938),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          mentor?.user!.location ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.home_work_outlined,
                                    size: 20,
                                    color: Color(0xffE78938),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    mentor?.user!.experiences!
                                            .firstWhere((element) =>
                                                element.isCurrentJob == true)
                                            .company ??
                                        '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color(0xffE78938),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            mentor?.user!.about ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff313030),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color(0xffE78938), // Primary color
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 34.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                              onPressed: () {
                                final linkedlnlink =
                                    mentor?.user!.linkedin ?? '';
                                _launchURL(linkedlnlink);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/Handoff/icon/social-icons/linkedin.png',
                                    width: 20.0,
                                    height: 20.0,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    "Linkedin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Skill",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color(0xffE78938),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: mentor?.user!.skills
                                      ?.map((skill) => SkillCard(skill: skill))
                                      .toList() ??
                                  [const Text('No skills')],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Experience",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color(0xffE78938),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: mentor?.user!.experiences
                                    ?.where((experience) =>
                                        experience.isCurrentJob == false)
                                    .map((experience) {
                                  return ExperienceWidget(
                                    role: experience.jobTitle ?? 'No Job Title',
                                    company: experience.company ?? 'No Company',
                                  );
                                }).toList() ??
                                [const Text('No experiences')],
                          ),
                        ]),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String skill;
  SkillCard({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorStyle().secondaryColors,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(skill,
                style: FontFamily().regularText.copyWith(
                      fontSize: 14,
                    )),
          ),
        ),
      ),
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  final String role;
  final String company;
  ExperienceWidget({Key? key, required this.role, required this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.work_outline_outlined,
              size: 20, color: ColorStyle().primaryColors),
          const SizedBox(width: 8), // Sesuaikan sesuai dengan kebutuhan Anda
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Atur sesuai kebutuhan
            children: [
              Text(role, style: FontFamily().boldText.copyWith(fontSize: 16)),
              Text(company,
                  style: FontFamily().regularText.copyWith(fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
