import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sma/detail_mentor_SMA.dart';
import 'package:mentormatch_apps/mentee/service/service_SMA_mentor.dart';
import 'package:mentormatch_apps/mentor/model/category_SMA_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_mentor.dart';

class AllSMAScreen extends StatefulWidget {
  AllSMAScreen({Key? key}) : super(key: key);

  @override
  State<AllSMAScreen> createState() => _AllSMAScreenState();
}

class _AllSMAScreenState extends State<AllSMAScreen> {
  late Future<SMA> futureSMAData;

  @override
  void initState() {
    super.initState();
    futureSMAData = SMAServices().getSMAData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SMA>(
      future: futureSMAData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
           final mentors = snapshot.data!.mentors!.where((mentor) {
            // Periksa apakah mentor memiliki setidaknya satu kelas yang tersedia
            return mentor.mentorClass!
                .any((classMentor) => classMentor.isAvailable == true);
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
              // create for experience is current job true or false
              ExperienceSMA? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceSMA(),
              );
              // Fungsi untuk mendapatkan slot yang tersedia
              int getAvailableSlotCount(ClassMentorSMA kelas) {
                int approvedCount = kelas.transactions
                        ?.where((t) => t.paymentStatus == "Approved")
                        .length ??
                    0;

                int pendingCount = kelas.transactions
                        ?.where((t) => t.paymentStatus == "Pending")
                        .length ??
                    0;

                int totalApprovedAndPendingCount = approvedCount + pendingCount;

                // Jumlah slot yang tersedia adalah maksimum partisipan dikurangi dengan total transaksi yang telah disetujui dan sedang diproses
                int availableSlots =
                    (kelas.maxParticipants ?? 0) - totalApprovedAndPendingCount;
                // Pastikan slot yang tersedia tidak negatif
                return availableSlots > 0 ? availableSlots : 0;
              }

// Fungsi untuk menentukan apakah semua kelas dalam daftar mentor dianggap penuh
              bool allClassesFull = mentor.mentorClass!.every((classMentor) {
                int availableSlotCount = getAvailableSlotCount(classMentor);
                return availableSlotCount <= 0;
              });

              String availabilityStatus = allClassesFull ? 'Full' : 'Available';
              Color buttonColor = allClassesFull
                  ? ColorStyle().disableColors
                  : ColorStyle().primaryColors;

              String company = currentJob?.company ?? 'Placeholder Company';
              String jobTitle = currentJob?.jobTitle ?? 'Placeholder Job';
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardItemMentor(
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorSMAScreen(
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
                  title: availabilityStatus,
                  color: buttonColor,
                  onPressesd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorSMAScreen(
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
            },

            shrinkWrap: true,
            physics:
                ScrollPhysics(), // Allows scrolling within a SingleChildScrollView
          );
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}
