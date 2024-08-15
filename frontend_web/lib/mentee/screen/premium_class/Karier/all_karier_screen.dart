import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/category_Karier_model.dart';

import 'package:my_flutter_app/mentee/screen/premium_class/Karier/detail_mentor_karier_screen.dart';
import 'package:my_flutter_app/mentee/service/service_Karier.dart';
import 'package:my_flutter_app/widget/card_mentor.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class AllKarierScreen extends StatefulWidget {
  AllKarierScreen({Key? key}) : super(key: key);

  @override
  State<AllKarierScreen> createState() => _AllKarierScreenState();
}

class _AllKarierScreenState extends State<AllKarierScreen> {
  late Future<Karier> futureKarierData;

  @override
  void initState() {
    super.initState();
    futureKarierData = KarierServices().getKarierData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Karier>(
      future: futureKarierData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final mentors = snapshot.data!.mentors!.where((mentor) {
            // Periksa apakah mentor memiliki setidaknya satu kelas yang tersedia
            return mentor.mentorClass!
                .any((classMentor) => classMentor.isAvailable == true);
          }).toList();

          if (mentors.isEmpty) {
            return WidgetMentorIsNotEmpety();
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 350,
                maxCrossAxisExtent: 250),
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              final mentor = mentors[index];
              // create for experience is current job true or false
              ExperienceKarier? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceKarier(),
              );

              // Fungsi untuk mendapatkan slot yang tersedia
              int getAvailableSlotCount(ClassMentorKarier kelas) {
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
                        builder: (context) => DetailMentorKarierScreen(
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
                  title: availabilityStatus,
                  color: buttonColor,
                  onPressesd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMentorKarierScreen(
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
