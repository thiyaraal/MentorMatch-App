import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/session_model.dart';
import 'package:my_flutter_app/mentee/screen/session/detail_mentor_session_screen.dart';
import 'package:my_flutter_app/mentee/service/session_mentor_service.dart';
import 'package:my_flutter_app/widget/card_mentor.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class BackEndSessionScreen extends StatefulWidget {
  BackEndSessionScreen({Key? key}) : super(key: key);

  @override
  State<BackEndSessionScreen> createState() => _BackEndSessionScreenState();
}

class _BackEndSessionScreenState extends State<BackEndSessionScreen> {
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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.hasData && snapshot.data!.mentors!.isNotEmpty) {
         final mentors = snapshot.data!.mentors!
              .where((mentor) => mentor.session!.any((sessionElement) =>
                  sessionElement.isActive == true &&
                  sessionElement.category == "Back End"))
              .toList();
          if (mentors.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('No mentors available')),
                  )),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 350,
                maxCrossAxisExtent: 250),
            itemCount: mentors.length,
            itemBuilder: (context, index) {
               /// membawa data session category = "Back End" ke detail session
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
              SessionElement sessionElement = mentor.session!.first;
              int maxParticipants = sessionElement.maxParticipants ?? 0;
              int currentParticipants = sessionElement.participant?.length ?? 0;
              int availableSlots = maxParticipants - currentParticipants;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemMentor(
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMentorSessionScreen(
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
                  title: isSessionFull ? "Full Booked" : "Available",
                  color: buttonColor,
                  onPressesd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorSessionScreen(
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
