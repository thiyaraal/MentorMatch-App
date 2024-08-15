import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/class_submission_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/my_session_mentor.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/premium_class_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class MyClassMentorListScreen extends StatefulWidget {
  const MyClassMentorListScreen({super.key});

  @override
  State<MyClassMentorListScreen> createState() =>
      _MyClassMentorListScreenState();
}

class _MyClassMentorListScreenState extends State<MyClassMentorListScreen> {
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationsCount = 0;
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

  Future<void> fetchData() async {
    setState(() {
      classData = ListClassMentor().fetchClassData();
      sessionData = ListClassMentor().fetchSessionsForCurrentUser();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
    fetchData();
  }

  Future<void> _fetchUnreadNotificationsCount() async {
    try {
      final notifications =
          await _notificationService.fetchNotificationsForCurrentUser();
      final unreadCount =
          notifications.where((notification) => !notification.isRead!).length;
      setState(() {
        _unreadNotificationsCount = unreadCount;
      });
    } catch (e) {
      // Handle error appropriately
    }
  }

// tab pengajuan kelas

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
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: AppBar(
        backgroundColor: ColorStyle().whiteColors,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/Handoff/logo/LogoMobile.png',
              width: 120,
              height: 120,
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationMentorScreen(),
                      ),
                    ).then((_) {
                      _fetchUnreadNotificationsCount(); // Fetch the unread count when returning to this screen
                    });
                  },
                  icon: const Icon(Icons.notifications_none_outlined),
                  color: ColorStyle().secondaryColors,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$_unreadNotificationsCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
      body: FutureBuilder<MyClassMentorMondel>(
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
                  if (sessionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height / 2.0,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else if (sessionSnapshot.hasError) {
                    return Text('Error: ${sessionSnapshot.error}');
                  } else if (sessionSnapshot.hasData) {
                    final sessions = sessionSnapshot.data ?? [];
                    final sessionCount = _getSessionCount(sessions);
                    return ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchBarWidgetMentor(
                                title: 'search by mentee name,or class name'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        height: 38,
                                        decoration: isClassSubmissionActive
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: ColorStyle()
                                                    .secondaryColors,
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: ColorStyle()
                                                      .secondaryColors,
                                                ),
                                              ),
                                        child: TextButton(
                                          onPressed: () {
                                            changeClass("Class Submission");
                                          },
                                          child: Text(
                                            "Class Submission ( $classSubmissionCount )",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                  color: isClassSubmissionActive
                                                      ? ColorStyle().whiteColors
                                                      : ColorStyle()
                                                          .secondaryColors,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        height: 38,
                                        decoration: isPremiumClassActive
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: ColorStyle()
                                                    .secondaryColors,
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: ColorStyle()
                                                      .secondaryColors,
                                                ),
                                              ),
                                        child: TextButton(
                                          onPressed: () {
                                            changeClass("Premium Class");
                                          },
                                          child: Text(
                                            "Premium Class ( $premiumClassCount )",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                  color: isPremiumClassActive
                                                      ? ColorStyle().whiteColors
                                                      : ColorStyle()
                                                          .secondaryColors,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        height: 38,
                                        decoration: isSessionActive
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: ColorStyle()
                                                    .secondaryColors,
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: ColorStyle()
                                                      .secondaryColors,
                                                ),
                                              ),
                                        child: TextButton(
                                          onPressed: () {
                                            changeClass("My Session");
                                          },
                                          child: Text(
                                            "Session ( $sessionCount )",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                  color: isSessionActive
                                                      ? ColorStyle().whiteColors
                                                      : ColorStyle()
                                                          .secondaryColors,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                isClassSubmissionActive
                                    ? const ClassSubmissionMentorScreen()
                                    : isSessionActive
                                        ? MySessionCreate()
                                        : isPremiumClassActive
                                            ? PremiumClassMentorScreen()
                                            : const ClassSubmissionMentorScreen()
                              ],
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
