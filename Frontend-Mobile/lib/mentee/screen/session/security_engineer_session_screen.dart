import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/session/detail_session_mentor.dart';
import 'package:mentormatch_apps/mentee/service/session_mentor_service.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class SecurityEngineerSessionScreen extends StatefulWidget {
  SecurityEngineerSessionScreen({Key? key}) : super(key: key);

  @override
  State<SecurityEngineerSessionScreen> createState() =>
      _SecurityEngineerSessionScreenState();
}

class _SecurityEngineerSessionScreenState
    extends State<SecurityEngineerSessionScreen> {
  late Future<Session> futureSessionData;

  @override
  void initState() {
    super.initState();
    futureSessionData = SessionServices().getSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Session>(
      future: futureSessionData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.mentors!.isNotEmpty) {
          final mentors = snapshot.data!.mentors!
              .where((mentor) => mentor.session!.any((sessionElement) =>
                  sessionElement.isActive == true &&
                  sessionElement.category == "Security Engineer"))
              .toList();
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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              final mentor = mentors[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              final currentExperience = mentor.experiences!.firstWhere(
                (experience) => experience.isCurrentJob ?? false,
                orElse: () =>
                    Experience(), // Menyediakan default Experience jika tidak ditemukan
              );

              ////// session active///////
              final activeSessions =
                  mentor.session!.where((s) => s.isActive == true).toList();
              //// buat session full apabila jumlah participant sudah mencapai maxParticipants
              final isSessionFull = activeSessions.isNotEmpty &&
                  activeSessions.any((session) =>
                      session.participant!.length >= session.maxParticipants!);

              ///numberOfParticipants = jumlah participant yang sudah join
              final numberOfParticipants = activeSessions.isNotEmpty
                  ? activeSessions.first.participant!.length
                  : 0;
              ////// button color is full //////
              final Color buttonColor = isSessionFull
                  ? ColorStyle().disableColors
                  : ColorStyle().primaryColors;
              ////// slot///////
              SessionData sessionElement = mentor.session!.first;
              int maxParticipants = sessionElement.maxParticipants ?? 0;
              int currentParticipants = sessionElement.participant?.length ?? 0;
              int availableSlots = maxParticipants - currentParticipants;
              return Container(
                margin: const EdgeInsets.only(right: 8.0),
                height: 250,
                width: 150,
                child: CardItemMentor(
                   onTap: (){
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
                  // apabila session penuh maka tiitlenya " session full" , tetapi apabila tidak full maka " available"
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
                                    (mentor.session!.first.participant
                                            ?.length ??
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
                  job: currentExperience.jobTitle ?? '',
                  company: currentExperience.company ?? 'Placeholder Company',
                ),
              );
            },
            shrinkWrap: true,
            physics:
                ScrollPhysics(), // Mengizinkan scroll jika di dalam SingleChildScrollView
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
