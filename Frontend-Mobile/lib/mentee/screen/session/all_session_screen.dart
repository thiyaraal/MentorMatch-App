import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/Session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllSessionScreen extends StatefulWidget {
  AllSessionScreen({Key? key}) : super(key: key);

  @override
  State<AllSessionScreen> createState() => _AllSessionScreenState();
}

class _AllSessionScreenState extends State<AllSessionScreen> {
  late Future<Session> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = SessionServices().getSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Session>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Menampilkan mentor yang isActive == true
          final mentors = snapshot.data!.mentors ?? [];

// Logging data yang diterima
          print('Total mentors: ${mentors.length}');

// Filter mentor yang memiliki sesi aktif dan valid
          final activeMentors = mentors.where((mentor) {
            final activeSessions = mentor.session?.where((session) {
              final sessionDate = DateTime.tryParse(session.dateTime ?? "");
              return session.isActive == true &&
                  sessionDate != null &&
                  sessionDate.isAfter(DateTime.now());
            }).toList();
            return activeSessions != null && activeSessions.isNotEmpty;
          }).toList();
          if (mentors.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('No mentors available')),
                  )),
            );
          }

          print('Active mentors with valid sessions: ${activeMentors.length}');

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 350,
                maxCrossAxisExtent: 250),
            itemCount: activeMentors.length,
            itemBuilder: (context, index) {
              final mentor = activeMentors[index];
              final mentorId = mentor.id ?? "";

              // Mengambil semua sesi aktif dari mentor
              final activeSessions = mentor.session
                      ?.where((session) => session.isActive == true)
                      .toList() ??
                  [];

              // Filter sesi berdasarkan tanggal
              final validSessions = activeSessions.where((session) {
                final sessionDate = DateTime.parse(session.dateTime ?? "");
                return sessionDate.isAfter(DateTime.now());
              }).toList();

              // Mendapatkan pengalaman kerja terkini mentor
              final currentExperience = mentor.experiences?.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () => Experience(),
              );

              // Mendapatkan jumlah peserta dan slot tersedia untuk sesi pertama yang valid
              final firstValidSession =
                  validSessions.isNotEmpty ? validSessions.first : null;
              final numberOfParticipants =
                  firstValidSession?.participant?.length ?? 0;
              final availableSlots = firstValidSession != null
                  ? firstValidSession.maxParticipants! - numberOfParticipants
                  : 0;
              // Menentukan apakah sesi penuh
              final isSessionFull = availableSlots <= 0;

              // Mendapatkan warna tombol sesuai dengan status ketersediaan sesi
              final Color buttonColor = isSessionFull
                  ? ColorStyle().disableColors
                  : ColorStyle().primaryColors;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemMentor(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorSessionsNew(
                          session: mentor.session,
                          availableSlots: mentor.session!.isEmpty
                              ? 0
                              : mentor.session!.first.maxParticipants! -
                                  (mentor.session!.first.participant?.length ??
                                      0),
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
                        builder: (context) => DetailMentorSessionsNew(
                          session: mentor.session,
                          availableSlots: mentor.session!.isEmpty
                              ? 0
                              : mentor.session!.first.maxParticipants! -
                                  (mentor.session!.first.participant?.length ??
                                      0),
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
                  job: currentExperience?.jobTitle ?? '',
                  company: currentExperience?.company ?? 'Placeholder Company',
                ),
              );
            },
            shrinkWrap: true,
            physics: ScrollPhysics(),
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
