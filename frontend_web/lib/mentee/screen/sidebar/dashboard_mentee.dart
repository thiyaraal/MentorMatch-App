import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentee/model/mentor_model.dart';
import 'package:my_flutter_app/mentee/model/session_model.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_mentor_all_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/premiumclass_page.dart';
import 'package:my_flutter_app/mentee/screen/session/detail_mentor_session_screen.dart';
import 'package:my_flutter_app/mentee/screen/session/session_screen.dart';
import 'package:my_flutter_app/mentee/service/mentor_service.dart';
import 'package:my_flutter_app/mentee/service/session_mentor_service.dart';
import 'package:my_flutter_app/widget/card_mentor.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class DashboardMentee extends StatefulWidget {
  const DashboardMentee({super.key});

  @override
  State<DashboardMentee> createState() => _DashboardMenteeState();
}

class _DashboardMenteeState extends State<DashboardMentee> {
  late Future<List<dynamic>> _futureData;
  final SessionServices _sessionServices = SessionServices();
  final MentorService _mentorService = MentorService();

  @override
  void initState() {
    super.initState();

    _futureData = Future.wait([
      _sessionServices.getSessionData(),
      _mentorService.fetchFilteredMentors(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 2.0,
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data'));
          } else {
            var mentorSessionData = snapshot.data![0]
                as Session; // mentor session yang di tampilkan hanya yang isActive == true
            var mentorClassData = snapshot.data![1]
                as MentorClassModel; // mentor class yang di tampilkan hanya yang isAvailable == true

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mentor Premium Class",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0A1737),
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PremiumClassPage(),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: ColorStyle().disableColors,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // Tentukan panjang daftar mentor yang telah difilter
                      children: List.generate(
                          mentorClassData.mentors!
                                      .where((mentor) => mentor.mentorClass!
                                          .any((kelas) =>
                                              kelas.isAvailable == true))
                                      .length >
                                  6
                              ? 6
                              : mentorClassData.mentors!
                                  .where((mentor) => mentor.mentorClass!.any(
                                      (kelas) => kelas.isAvailable == true))
                                  .length, (index) {
                        // Dapatkan mentor yang telah difilter
                        final mentor = mentorClassData.mentors!
                            .where((mentor) => mentor.mentorClass!
                                .any((kelas) => kelas.isAvailable == true))
                            .toList()[index];

                        ExperienceClassAll? currentJob =
                            mentor.experiences?.firstWhere(
                          (exp) => exp.isCurrentJob ?? false,
                          orElse: () => ExperienceClassAll(),
                        );

                        // Fungsi untuk mendapatkan slot yang tersedia
                        int getAvailableSlotCount(ClassAll kelas) {
                          int approvedCount = kelas.transactions
                                  ?.where((t) => t.paymentStatus == "Approved")
                                  .length ??
                              0;

                          int pendingCount = kelas.transactions
                                  ?.where((t) => t.paymentStatus == "Pending")
                                  .length ??
                              0;

                          int totalApprovedAndPendingCount =
                              approvedCount + pendingCount;

                          // Jumlah slot yang tersedia adalah maksimum partisipan dikurangi dengan total transaksi yang telah disetujui dan sedang diproses
                          int availableSlots = (kelas.maxParticipants ?? 0) -
                              totalApprovedAndPendingCount;
                          // Pastikan slot yang tersedia tidak negatif
                          return availableSlots > 0 ? availableSlots : 0;
                        }

                        // Fungsi untuk menentukan apakah semua kelas dalam daftar mentor dianggap penuh
                        bool allClassesFull =
                            mentor.mentorClass!.every((classMentor) {
                          int availableSlotCount =
                              getAvailableSlotCount(classMentor);
                          return availableSlotCount <= 0;
                        });

                        String company =
                            currentJob?.company ?? 'Placeholder Company';
                        String jobTitle =
                            currentJob?.jobTitle ?? 'Placeholder Job';

                        return CardItemMentor(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMentorAllScreen(
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
                                  mentorReviews: mentor.mentorReviews ?? [],
                                ),
                              ),
                            );
                          },
                          onPressesd: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMentorAllScreen(
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
                                  mentorReviews: mentor.mentorReviews ?? [],
                                ),
                              ),
                            );
                          },
                          imagePath: mentor.photoUrl.toString(),
                          name: mentor.name ?? 'No Name',
                          job: jobTitle,
                          company: company,
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mentor Session",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0A1737),
                          fontSize: 16,
                        ),
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
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: ColorStyle().disableColors,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          mentorSessionData.mentors!
                                      .where((mentor) => mentor.session!.any(
                                          (session) =>
                                              session.isActive == true))
                                      .length >
                                  6
                              ? 6
                              : mentorSessionData.mentors!
                                  .where((mentor) => mentor.session!.any(
                                      (session) => session.isActive == true))
                                  .length, (index) {
                        final mentor = mentorSessionData.mentors!
                            .where((mentor) => mentor.session!
                                .any((session) => session.isActive == true))
                            .toList()[index];

                        final currentExperience =
                            mentor.experiences!.firstWhere(
                          (experience) => experience.isCurrentJob ?? false,
                          orElse: () =>
                              Experience(), // Menyediakan default Experience jika tidak ditemukan
                        );

                        //buat session active ketika isActive = true
                        final activeSessions = mentor.session!
                            .where((s) => s.isActive == true)
                            .toList();
                        //// buat session full apabila jumlah participant sudah mencapai maxParticipants
                        final isSessionFull = activeSessions.isNotEmpty &&
                            activeSessions.any((session) =>
                                session.participant!.length >=
                                session.maxParticipants!);

                        ///numberOfParticipants = jumlah participant yang sudah join
                        final numberOfParticipants = activeSessions.isNotEmpty
                            ? activeSessions.first.participant!.length
                            : 0;
                        ////// button color is full //////
                        final Color buttonColor = isSessionFull
                            ? ColorStyle().disableColors
                            : ColorStyle().primaryColors;
                        ////// slot///////
                        SessionElement sessionElement = mentor.session!.first;
                        int maxParticipants =
                            sessionElement.maxParticipants ?? 0;
                        int currentParticipants =
                            sessionElement.participant?.length ?? 0;
                        int availableSlots =
                            maxParticipants - currentParticipants;
                        return Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          height: 350,
                          width: 250,
                          child: CardItemMentor(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMentorSessionScreen(
                                    session: mentor.session,
                                    availableSlots: availableSlots,
                                    detailmentor: mentor,
                                    totalParticipants: numberOfParticipants,
                                    mentorReviews: mentor.mentorReviews ?? [],
                                  ),
                                ),
                              );
                            },
                            title: isSessionFull ? "Full Booked" : "Available",
                            color: buttonColor,
                            onPressesd: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMentorSessionScreen(
                                    session: mentor.session,
                                    availableSlots: availableSlots,
                                    detailmentor: mentor,
                                    totalParticipants: numberOfParticipants,
                                    mentorReviews: mentor.mentorReviews ?? [],
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
                      }),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
