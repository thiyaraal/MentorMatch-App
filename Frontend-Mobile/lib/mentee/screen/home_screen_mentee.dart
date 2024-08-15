import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/detail_mentor_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/karier/karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sma/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/smp/SMP_screen.dart';
import 'package:mentormatch_apps/mentee/screen/session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/screen/session/session_screen.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/mentor_model.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/mentor/service/mentor_service.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class HomeMenteeScreen extends StatefulWidget {
  HomeMenteeScreen({Key? key}) : super(key: key);

  @override
  State<HomeMenteeScreen> createState() => _HomeMenteeScreenState();
}

class _HomeMenteeScreenState extends State<HomeMenteeScreen> {
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

  int _unreadNotificationsCount = 0;
  late Future<List<dynamic>> _futureData;
  // Membuat instance dari kedua service
  final SessionServices _sessionServices = SessionServices();
  final MentorService _mentorService = MentorService();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
    _futureData = Future.wait([
      _sessionServices.getSessionData(),
      _mentorService.fetchFilteredMentors(),
    ]);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
            PopMenuButtonWidget(
              title: "Program & Layanan",
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
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data'));
          } else {
            // mentor session yang di tampilkan hanya yang isActive == true
            var mentorSessionData = snapshot.data![0] as Session;

            /// tampilkan mentor yang memiliki kelas semua kelas nya isAvailable == true
            var mentorClassData = snapshot.data![1] as MentorClassModel;

            return CustomScrollView(slivers: <Widget>[
              // Replace the SliverPadding and SliverGrid with the following:
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 0.0, bottom: 16.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Find Your Mentor",
                        style: FontFamily().boldText.copyWith(
                              color: ColorStyle().secondaryColors,
                              fontSize: 14,
                            ),
                      ),
                      SearchBarWidgetMentee(),
                      const SizedBox(height: 8.0),
                      TittleTextField(
                        title: "Premium Class",
                        color: ColorStyle().secondaryColors,
                      ),
                      Text(
                        "Temukan mentor yang sesuai dengan tingkat pendidikan kamu",
                        style: FontFamily().regularText.copyWith(
                              color: ColorStyle().disableColors,
                              fontSize: 12,
                            ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis
                            .horizontal, // Mengatur pengguliran ke arah horizontal
                        child: Row(
                          children: [
                            ButtonEducationLevels(
                              title: "SD",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SDScreen(),
                                  ),
                                );
                              },
                            ),
                            ButtonEducationLevels(
                              title: "SMP",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SMPScreen()));
                              },
                            ),
                            ButtonEducationLevels(
                              title: "SMA",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SMAScreen()));
                              },
                            ),
                            ButtonEducationLevels(
                              title: "Kuliah",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KuliahScreen(),
                                  ),
                                );
                              },
                            ),
                            ButtonEducationLevels(
                              title: "Karier",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KarierScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TittleTextField(
                            title: "Mentor Premium",
                            color: ColorStyle().secondaryColors,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PremiumClassScreen(),
                                )
                                // ignore: avoid_returning_null
                                ,
                                (route) => false,
                              );
                            },
                            child: Text(
                              "See All",
                              style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 250, // Sesuaikan tinggi sesuai desain Anda
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: mentorClassData.mentors!
                                .where((mentor) => mentor.mentorClass!
                                    .any((kelas) => kelas.isAvailable == true))
                                .take(6) // Hanya ambil 6 mentor pertama
                                .map((mentor) {
                              // Cek apakah mentor memiliki setidaknya satu kelas yang tersedia
                              bool hasAvailableClass = mentor.mentorClass!
                                  .any((kelas) => kelas.isAvailable == true);
                              if (!hasAvailableClass) {
                                // Jika mentor tidak memiliki kelas yang tersedia, lewati
                                return SizedBox.shrink();
                              }

                              ExperienceClassAll? currentJob =
                                  mentor.experiences?.firstWhere(
                                (exp) => exp.isCurrentJob ?? false,
                                orElse: () => ExperienceClassAll(),
                              );

                              String company =
                                  currentJob?.company ?? 'Placeholder Company';
                              String jobTitle =
                                  currentJob?.jobTitle ?? 'Placeholder Job';

                              return Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                height: 250,
                                width: 150,
                                child: CardItemMentor(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailMentorClassAllScreen(
                                          reviews: mentor.mentorReviews ?? [],
                                          experiences: mentor.experiences ?? [],
                                          email: mentor.email ?? '',
                                          classes: mentor.mentorClass ?? [],
                                          about: mentor.about ?? '',
                                          name: mentor.name ?? 'No Name',
                                          photoUrl: mentor.photoUrl ?? '',
                                          skills: mentor.skills ?? [],
                                          classid: mentor.id.toString(),
                                          company: company,
                                          job: jobTitle,
                                          linkedin: mentor.linkedin ?? '',
                                          mentor: mentor,
                                          location: mentor.location ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  onPressesd: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailMentorClassAllScreen(
                                          reviews: mentor.mentorReviews ?? [],
                                          experiences: mentor.experiences ?? [],
                                          email: mentor.email ?? '',
                                          classes: mentor.mentorClass ?? [],
                                          about: mentor.about ?? '',
                                          name: mentor.name ?? 'No Name',
                                          photoUrl: mentor.photoUrl ?? '',
                                          skills: mentor.skills ?? [],
                                          classid: mentor.id.toString(),
                                          company: company,
                                          job: jobTitle,
                                          linkedin: mentor.linkedin ?? '',
                                          mentor: mentor,
                                          location: mentor.location ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath: mentor.photoUrl.toString(),
                                  name: mentor.name ?? 'No Name',
                                  job: jobTitle,
                                  company: company,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TittleTextField(
                            title: "Mentor Session",
                            color: ColorStyle().secondaryColors,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SessionScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "See All",
                              style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height:
                            250, // Adjust the height according to your design
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              mentorSessionData.mentors!
                                          .where((mentor) => mentor.session!
                                              .any((session) =>
                                                  session.isActive == true &&
                                                  DateTime.parse(
                                                          session.dateTime!)
                                                      .isAfter(DateTime.now())))
                                          .length >
                                      6
                                  ? 6
                                  : mentorSessionData.mentors!
                                      .where((mentor) => mentor.session!.any(
                                          (session) =>
                                              session.isActive == true &&
                                              DateTime.parse(session.dateTime!)
                                                  .isAfter(DateTime.now())))
                                      .length,
                              (index) {
                                final mentor = mentorSessionData.mentors!
                                    .where((mentor) => mentor.session!.any(
                                        (session) =>
                                            session.isActive == true &&
                                            DateTime.parse(session.dateTime!)
                                                .isAfter(DateTime.now())))
                                    .toList()[index];

                                final currentExperience =
                                    mentor.experiences!.firstWhere(
                                  (experience) =>
                                      experience.isCurrentJob ?? false,
                                  orElse: () =>
                                      Experience(), // Default Experience if not found
                                );

                                // Filter sessions that are active and scheduled for a future time
                                final activeSessions = mentor.session!
                                    .where((s) =>
                                        s.isActive == true &&
                                        DateTime.parse(s.dateTime!)
                                            .isAfter(DateTime.now()))
                                    .toList();

                                // Check if any of the active sessions are full
                                final isSessionFull =
                                    activeSessions.isNotEmpty &&
                                        activeSessions.any((session) =>
                                            session.participant!.length >=
                                            session.maxParticipants!);

                                // Number of participants in the first active session
                                final numberOfParticipants = activeSessions
                                        .isNotEmpty
                                    ? activeSessions.first.participant!.length
                                    : 0;

                                // Determine button color based on session capacity
                                final Color buttonColor = isSessionFull
                                    ? ColorStyle().disableColors
                                    : ColorStyle().primaryColors;

                                // Determine available slots in the first active session
                                SessionData sessionElement =
                                    mentor.session!.first;
                                int maxParticipants =
                                    sessionElement.maxParticipants ?? 0;
                                int currentParticipants =
                                    sessionElement.participant?.length ?? 0;
                                int availableSlots =
                                    maxParticipants - currentParticipants;
                                return Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  height: 250,
                                  width: 150,
                                  child: CardItemMentor(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMentorSessionsNew(
                                            session: mentor.session,
                                            availableSlots:
                                                mentor.session!.isEmpty
                                                    ? 0
                                                    : mentor.session!.first
                                                            .maxParticipants! -
                                                        (mentor
                                                                .session!
                                                                .first
                                                                .participant
                                                                ?.length ??
                                                            0),
                                            detailmentor: mentor,
                                            totalParticipants:
                                                numberOfParticipants,
                                            mentorReviews:
                                                mentor.mentorReviews ?? [],
                                          ),
                                        ),
                                      );
                                    },
                                    // apabila session penuh maka tiitlenya " session full" , tetapi apabila tidak full maka " available"
                                    title: isSessionFull
                                        ? "Full Booked"
                                        : "Available",
                                    color: buttonColor,
                                    onPressesd: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMentorSessionsNew(
                                            session: mentor.session,
                                            availableSlots:
                                                mentor.session!.isEmpty
                                                    ? 0
                                                    : mentor.session!.first
                                                            .maxParticipants! -
                                                        (mentor
                                                                .session!
                                                                .first
                                                                .participant
                                                                ?.length ??
                                                            0),
                                            detailmentor: mentor,
                                            totalParticipants:
                                                numberOfParticipants,
                                            mentorReviews:
                                                mentor.mentorReviews ?? [],
                                          ),
                                        ),
                                      );
                                    },
                                    imagePath: mentor.photoUrl ??
                                        'assets/Handoff/ilustrator/profile.png',
                                    name: mentor.name ?? 'No Name',
                                    job: currentExperience.jobTitle ?? '',
                                    company: currentExperience.company ??
                                        'Placeholder Company',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]);
          }
        },
      ),
    );
  }
}
