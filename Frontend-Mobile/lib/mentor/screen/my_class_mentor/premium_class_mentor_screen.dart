import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/detail_my_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class PremiumClassMentorScreen extends StatefulWidget {
  const PremiumClassMentorScreen({super.key});

  @override
  State<PremiumClassMentorScreen> createState() =>
      _PremiumClassMentorScreenState();
}

class _PremiumClassMentorScreenState extends State<PremiumClassMentorScreen> {
  late Future<MyClassMentorMondel> classData;

  int _getPriority(AllClass userClass) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(userClass.startDate.toString());
    DateTime endDate = DateTime.parse(userClass.endDate.toString());

    int getAvailableSlotCount(AllClass userClass) {
      int approvedCount = userClass.transactions
              ?.where((t) => t.paymentStatus == "Approved")
              .length ??
          0;
      int pendingCount = userClass.transactions
              ?.where((t) => t.paymentStatus == "Pending")
              .length ??
          0;
      int totalApprovedAndPendingCount = approvedCount + pendingCount;
      return totalApprovedAndPendingCount;
    }

    int totalApprovedAndPendingCount = getAvailableSlotCount(userClass);

    bool isActive = userClass.isActive!;
    bool isAvailable = userClass.isAvailable!;
    bool isVerified = userClass.isVerified!;
    int maxParticipants = userClass.maxParticipants!;
    String buttonText = "Unavailable";

    if (isVerified &&
        isAvailable &&
        totalApprovedAndPendingCount < maxParticipants &&
        now.isBefore(startDate)) {
      buttonText = "Scheduled";
    } else if (totalApprovedAndPendingCount >= maxParticipants && !isActive) {
      buttonText = "Full";
    } else if (isActive) {
      buttonText = "Active";
    } else if (totalApprovedAndPendingCount > 0 && now.isAfter(endDate)) {
      buttonText = "Finished";
    } else if (isVerified &&
        totalApprovedAndPendingCount == 0 &&
        now.isAfter(startDate)) {
      buttonText = "Expired";
    }

    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
    switch (buttonText) {
      case "Active":
        return 1;
      case "Scheduled":
        return 2;
      case "Full":
        return 3;
      case "Finished":
        return 4;
      case "Expired":
        return 5;
      default:
        return 6;
    }
  }

  Widget createStatusButton(String title, Color color) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: FontFamily().boldText.copyWith(
              color: color,
              fontSize: 12,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    classData = ListClassMentor().fetchClassData();
    classData.then((value) {
      value.user?.userClass?.retainWhere((userClass) {
        int priority = _getPriority(userClass);
        return priority == 1 ||
            priority == 2 ||
            priority == 3 ||
            priority == 4 ||
            priority == 5;
      });
      value.user?.userClass =
          _sortClassesByPriority(value.user?.userClass ?? []);
    });
  }

  // sort class by priority (Active, Scheduled, Full, Finished, Expired)
  List<AllClass> _sortClassesByPriority(List<AllClass> userClass) {
    userClass.sort((a, b) {
      int priorityA = _getPriority(a);
      int priorityB = _getPriority(b);
      return priorityA.compareTo(priorityB);
    });
    return userClass;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyClassMentorMondel>(
      future: classData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2.0,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var userClass = snapshot.data!.user?.userClass!;
          if (userClass!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Handoff/ilustrator/empty.png',
                        width: 270,
                        height: 270,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
              child: Column(
                children: userClass!.map((data) {
                  int approvedTransactionsCount = data.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .length ??
                      0;

                  int statusButton = _getPriority(data);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMyClassMentorScreen(
                            feedbacks: data.feedbacks ?? [],
                            addressMentoring: data.address ?? 'Meeting Zoom',
                            locationMentoring: data.location ?? '',
                            approvedTransactionsCount:
                                approvedTransactionsCount,
                            transactions: data.transactions ?? [],
                            evaluation: data.evaluations ?? [],
                            learningMaterial: data.learningMaterial ?? [],
                            userClass: data,
                            aksesLinkZoom: data.zoomLink ?? '',
                            deskripsiKelas: data.description.toString(),
                            classid: data.id.toString(),
                            durationInDays: data.durationInDays ?? 0,
                            endDate: DateTime.parse(data.endDate ?? ''),
                            startDate: DateTime.parse(data.startDate ?? ''),
                            term: data.terms ?? [],
                            maxParticipants: data.maxParticipants ?? 0,
                            schedule: data.schedule ?? '',
                            targetLearning: data.targetLearning ?? [],
                            linkZoom: data.zoomLink ?? '',
                            namaKelas: data.name ?? '',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: ColorStyle().whiteColors,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (statusButton == 1)
                                createStatusButton(
                                    "Active", ColorStyle().succesColors),
                              if (statusButton == 2)
                                createStatusButton(
                                    "Scheduled", ColorStyle().secondaryColors),
                              if (statusButton == 3)
                                createStatusButton(
                                    "Full", ColorStyle().fullbookedColors),
                              if (statusButton == 4)
                                createStatusButton(
                                    "Finished", ColorStyle().disableColors),
                              if (statusButton == 5)
                                createStatusButton(
                                    "Expired", ColorStyle().errorColors),
                              const SizedBox(height: 12),
                              Text(
                                data.name ?? '',
                                style: FontFamily().boldText.copyWith(
                                    fontSize: 14,
                                    color: ColorStyle().blackColors),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Jumlah mentee terdaftar : $approvedTransactionsCount orang',
                                style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().blackColors,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Durasi kelas                        : ${data.durationInDays} hari',
                                style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().blackColors,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.0,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Center(child: Text('Kamu belum memiliki kelas saat ini')),
              ));
        }
      },
    );
  }
}
