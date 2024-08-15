import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/category_smp_model.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/detail_mentor_smp_screen.dart';
import 'package:my_flutter_app/mentee/service/service_SMP_mentor.dart';
import 'package:my_flutter_app/widget/card_mentor.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class AllSMPScreen extends StatefulWidget {
  AllSMPScreen({Key? key}) : super(key: key);

  @override
  State<AllSMPScreen> createState() => _AllSMPScreenState();
}

class _AllSMPScreenState extends State<AllSMPScreen> {
  late Future<SMP> futureSMPData;

  @override
  void initState() {
    super.initState();
    futureSMPData = SMPServices().getSMPData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SMP>(
      future: futureSMPData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
             // Filter mentors based on availability of classes
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
              ExperienceSMP? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceSMP(),
              );

              // Fungsi untuk mendapatkan slot yang tersedia
              int getAvailableSlotCount(ClassMentorSMP kelas) {
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
                        builder: (context) => DetailMentorSMPScreen(
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
                        builder: (context) => DetailMentorSMPScreen(
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
