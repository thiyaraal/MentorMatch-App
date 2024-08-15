import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/category_sd_model.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/detail_mentor_sd_screen.dart';
import 'package:my_flutter_app/mentee/service/service_SD_mentor.dart';
import 'package:my_flutter_app/widget/card_mentor.dart';
import 'package:my_flutter_app/widget/menucategory.dart';


class MathSDScreen extends StatefulWidget {
  MathSDScreen({Key? key}) : super(key: key);

  @override
  State<MathSDScreen> createState() => _MathSDScreenState();
}

class _MathSDScreenState extends State<MathSDScreen> {
  late Future<SD> futureSDData;

  @override
  void initState() {
    super.initState();
    futureSDData = SDServices().getSDData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SD>(
      future: futureSDData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
              final mentorsWithLanguageCategory = snapshot.data!.mentors!
              .where((mentor) => mentor.mentorClass!.any((mentorClass) =>
                  mentorClass.category == 'Matematika' &&
                  mentorClass.isAvailable == true))
              .toList();

           if (mentorsWithLanguageCategory.isEmpty) {
            return WidgetMentorIsNotEmpety();
          }

          return 
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 350,
                maxCrossAxisExtent: 250

                // ratio
                ),
            itemCount: mentorsWithLanguageCategory.length,
            itemBuilder: (context, index) {
               final mentor = mentorsWithLanguageCategory[index];
              // Logika untuk menentukan currentExperience sama seperti sebelumnya
              ExperienceSD? currentJob = mentor.experiences?.firstWhere(
                (exp) => exp.isCurrentJob ?? false,
                orElse: () => ExperienceSD(),
              );

              // Fungsi untuk mendapatkan slot yang tersedia
              int getAvailableSlotCount(ClassMentorSD kelas) {
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
              return CardItemMentor(
                 onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMentorSDScreen(
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
                      builder: (context) => DetailMentorSDScreen(
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
