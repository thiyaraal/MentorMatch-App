import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/Screens/my_class_mentor/edit_class_rejected.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/mentor/screens/create_class_and_session/create_class/persetujuan_create_class_mentor.dart';
import 'package:my_flutter_app/mentor/screens/my_class_mentor/pending_class_mentor_screen.dart';
import 'package:my_flutter_app/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class ClassSubmissionMentorScreen extends StatefulWidget {
  const ClassSubmissionMentorScreen({super.key});

  @override
  State<ClassSubmissionMentorScreen> createState() =>
      _ClassSubmissionMentorScreenState();
}

class _ClassSubmissionMentorScreenState
    extends State<ClassSubmissionMentorScreen> {
  late Future<MyClassMentorMondel> classData;

  int _getPriority(AllClass userClass) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(userClass.startDate.toString());

    bool isVerified = userClass.isVerified!;
    bool isActive = userClass.isActive!;
    bool isAvailable = userClass.isAvailable!;
    bool isRejected = userClass.rejectReason != null;
    String buttonText = "Unavailable";

    if (!isAvailable && !isVerified && !isActive && isRejected) {
      buttonText = "Rejected";
    } else if (!isAvailable &&
        !isVerified &&
        !isActive &&
        now.isBefore(startDate)) {
      buttonText = "Pending";
    }

    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
    switch (buttonText) {
      case "Rejected":
        return 1;
      case "Pending":
        return 2;
      default:
        return 3;
    }
  }

  Widget createStatusButton(String title, Color color) {
    return Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: FontFamily().boldText.copyWith(color: color, fontSize: 14),
        ));
  }

  @override
  void initState() {
    super.initState();

    classData = ListClassMentor().fetchClassData();

    classData.then((value) {
      value.user?.userClass?.retainWhere((userClass) {
        int priority = _getPriority(userClass);
        return priority == 1 || priority == 2;
      });
      value.user?.userClass =
          _sortClassesByPriority(value.user?.userClass ?? []);
    });
  }

  List<AllClass> _sortClassesByPriority(List<AllClass> classes) {
    classes.sort((a, b) => _getPriority(b).compareTo(_getPriority(a)));
    return classes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyClassMentorMondel>(
      future: classData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2.0,
              child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.user?.userClass != null) {
          var userClass = snapshot.data!.user!.userClass!;
          if (userClass.isEmpty) {
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
                        'assets/Handoff/ilustrator/empty_submission.png',
                        width: 270,
                        height: 270,
                      ),
                      const SizedBox(height: 20),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: ColorStyle().primaryColors,
                          backgroundColor: ColorStyle().primaryColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PersetujuanPremiClassMentor(),
                            ),
                          );
                        },
                        icon: Icon(Icons.add, color: ColorStyle().whiteColors),
                        label: Text(
                          "Buat Kelas",
                          style: FontFamily()
                              .boldText
                              .copyWith(color: ColorStyle().whiteColors),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: userClass.map((data) {
                  int approvedTransactionsCount = data.transactions
                          ?.where((transaction) =>
                              transaction.paymentStatus == "Approved")
                          .length ??
                      0;

                  int statusButton = _getPriority(data);
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        if (statusButton == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditRejectedClass(
                                classData: data,
                              ),
                            ),
                          );
                        } else if (statusButton == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PendingClassMentorScreen(
                                feedbacks: data.feedbacks ?? [],
                                addressMentoring:
                                    data.address ?? 'Meeting Zoom',
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
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: ColorStyle().tertiaryColors,
                            width: 2,
                          ),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (statusButton == 1)
                                createStatusButton(
                                    "Rejected", ColorStyle().errorColors),
                              if (statusButton == 2)
                                createStatusButton(
                                    "Pending", ColorStyle().pendingColors),
                              const SizedBox(height: 12),
                              Text(data.name ?? '',
                                  style: FontFamily().titleText.copyWith(
                                        color: ColorStyle().primaryColors,
                                      )),
                              const SizedBox(height: 12),
                              Text(
                                'Jumlah mentee terdaftar : ${approvedTransactionsCount}',
                                style: FontFamily().regularText,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                //durationIndays
                                'Durasi kelas : ${data.durationInDays} hari',
                                style: FontFamily().regularText,
                              ),
                              const SizedBox(height: 12),
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
                      'assets/Handoff/ilustrator/empty_submission.png',
                      width: 270,
                      height: 270,
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorStyle().primaryColors,
                        backgroundColor: ColorStyle().primaryColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersetujuanPremiClassMentor(),
                          ),
                        );
                      },
                      icon: Icon(Icons.add, color: ColorStyle().whiteColors),
                      label: Text(
                        "Buat Kelas",
                        style: FontFamily()
                            .boldText
                            .copyWith(color: ColorStyle().whiteColors),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
