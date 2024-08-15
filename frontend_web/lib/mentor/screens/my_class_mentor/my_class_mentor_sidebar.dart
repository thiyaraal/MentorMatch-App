import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/Screens/my_class_mentor/my_session_mentor.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/mentor/screens/my_class_mentor/class_submission_mentor.dart';
import 'package:my_flutter_app/mentor/screens/my_class_mentor/premium_class_mentor.dart';
import 'package:my_flutter_app/mentor/service/myClassCreate_Mentor_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class MyClassMentorListScreen extends StatefulWidget {
  final String initialSubMenu; // New parameter for initial sub-menu

  const MyClassMentorListScreen({
    super.key,
    this.initialSubMenu = 'Class Submission',
  });

  @override
  State<MyClassMentorListScreen> createState() =>
      _MyClassMentorListScreenState();
}

class _MyClassMentorListScreenState extends State<MyClassMentorListScreen> {
  late Future<MyClassMentorMondel> classData;
  late Future<List<Session>> sessionData;

  int _getClassPriority(AllClass userClass) {
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

    bool isVerified = userClass.isVerified!;
    bool isActive = userClass.isActive!;
    bool isAvailable = userClass.isAvailable!;
    bool isRejected = userClass.rejectReason != null;
    int maxParticipants = userClass.maxParticipants!;
    String buttonText = "Unavailable";

    if (!isAvailable && !isVerified && !isActive && isRejected) {
      buttonText = "Rejected";
    } else if (!isAvailable &&
        !isVerified &&
        !isActive &&
        now.isBefore(startDate)) {
      buttonText = "Pending";
    } else if (isVerified &&
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

    return _calculateClassPriority(buttonText);
  }

  int _calculateClassPriority(String buttonText) {
    switch (buttonText) {
      case "Rejected":
        return 1;
      case "Pending":
        return 2;
      case "Scheduled":
        return 3;
      case "Full":
        return 4;
      case "Active":
        return 5;
      case "Finished":
        return 6;
      case "Expired":
        return 7;
      default:
        return 0;
    }
  }

  int _getSessionPriority(Session userSessions) {
    String buttonText = "Available";

    DateTime startTime = DateTime.parse(userSessions.startTime!);
    startTime = startTime.toLocal().subtract(const Duration(hours: 7));

    DateTime endTime = DateTime.parse(userSessions.endTime!);
    endTime = endTime.toLocal().subtract(const Duration(hours: 7));

    if (userSessions.isActive == true &&
        userSessions.participant!.length < userSessions.maxParticipants! &&
        DateTime.now().isBefore(startTime)) {
      buttonText = "Scheduled";
    } else if (userSessions.participant!.length ==
            userSessions.maxParticipants &&
        DateTime.now().isBefore(startTime)) {
      buttonText = "Full";
    } else if (userSessions.isActive == false &&
        userSessions.participant!.isNotEmpty &&
        DateTime.now().isBefore(endTime) &&
        DateTime.now().isAfter(startTime)) {
      buttonText = "Active";
    } else if (userSessions.participant!.isEmpty &&
        DateTime.now().isAfter(startTime)) {
      buttonText = "Expired";
    } else if (userSessions.participant!.isNotEmpty &&
        DateTime.now().isAfter(endTime)) {
      buttonText = "Finished";
    }

    return _calculateSessionPriority(buttonText);
  }

  int _calculateSessionPriority(String buttonText) {
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
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    changeClass(widget.initialSubMenu);
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      classData = ListClassMentor().fetchClassData();
      sessionData = ListClassMentor().fetchSessionsForCurrentUser();
    });
  }

  bool isClassSubmissionActive = true;
  bool isPremiumClassActive = false;
  bool isSessionActive = false; // Renamed for consistency

  void changeClass(String menu) {
    setState(() {
      if (menu == "Premium Class") {
        isClassSubmissionActive = false;
        isPremiumClassActive = true;
        isSessionActive = false;
      } else if (menu == "My Session") {
        isClassSubmissionActive = false;
        isPremiumClassActive = false;
        isSessionActive = true;
      } else {
        menu = "Class Submission";
        isClassSubmissionActive = true;
        isPremiumClassActive = false;
        isSessionActive = false;
      }
    });
  }

  int _getClassSubmissionCount(List<AllClass> classes) {
    return classes
        .where((c) => _getClassPriority(c) == 1 || _getClassPriority(c) == 2)
        .length;
  }

  int _getPremiumClassCount(List<AllClass> classes) {
    return classes
        .where((c) =>
            _getClassPriority(c) == 3 ||
            _getClassPriority(c) == 4 ||
            _getClassPriority(c) == 5 ||
            _getClassPriority(c) == 6 ||
            _getClassPriority(c) == 7)
        .length;
  }

  int _getSessionCount(List<Session> sessions) {
    return sessions
        .where((s) =>
            _getSessionPriority(s) == 1 ||
            _getSessionPriority(s) == 2 ||
            _getSessionPriority(s) == 3 ||
            _getSessionPriority(s) == 4 ||
            _getSessionPriority(s) == 5)
        .length;
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
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final classes = snapshot.data!.user?.userClass ?? [];
          final classSubmissionCount = _getClassSubmissionCount(classes);
          final premiumClassCount = _getPremiumClassCount(classes);

          return FutureBuilder<List<Session>>(
            future: sessionData,
            builder: (context, sessionSnapshot) {
              if (sessionSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: const Center(child: CircularProgressIndicator()));
              } else if (sessionSnapshot.hasError) {
                return Text('Error: ${sessionSnapshot.error}');
              } else if (sessionSnapshot.hasData) {
                final sessions = sessionSnapshot.data ?? [];
                final sessionCount = _getSessionCount(sessions);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: isClassSubmissionActive
                                      ? ColorStyle().secondaryColors
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                changeClass("Class Submission");
                              },
                              child: Text(
                                "Class Submission ( $classSubmissionCount )",
                                style: FontFamily().boldText.copyWith(
                                    color: isClassSubmissionActive
                                        ? ColorStyle().secondaryColors
                                        : ColorStyle().disableColors),
                              ),
                            ),
                          ),
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: isPremiumClassActive
                                      ? ColorStyle().secondaryColors
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                changeClass("Premium Class");
                              },
                              child: Text(
                                "Premium Class ( $premiumClassCount )",
                                style: FontFamily().boldText.copyWith(
                                    color: isPremiumClassActive
                                        ? ColorStyle().secondaryColors
                                        : ColorStyle().disableColors),
                              ),
                            ),
                          ),
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: isSessionActive
                                      ? ColorStyle().secondaryColors
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                changeClass("My Session");
                              },
                              child: Text(
                                "Session ( $sessionCount )",
                                style: FontFamily().boldText.copyWith(
                                    color: isSessionActive
                                        ? ColorStyle().secondaryColors
                                        : ColorStyle().disableColors),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        isClassSubmissionActive
                            ? const ClassSubmissionMentorScreen()
                            : isSessionActive
                                ? MySessionCreate()
                                : isPremiumClassActive
                                    ? const PremiumClassMentorScreen()
                                    : const ClassSubmissionMentorScreen()
                      ],
                    ),
                  ],
                );
              } else {
                return const Text('No data available');
              }
            },
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
