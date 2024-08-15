import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/booking_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/my_session_booking.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/premium_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_service.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class MyClassMenteeListScreen extends StatefulWidget {
  final String subMenu; // New parameter for initial sub-menu

  const MyClassMenteeListScreen({super.key, required this.subMenu});

  @override
  State<MyClassMenteeListScreen> createState() =>
      _MyClassMenteeListScreenState();
}

class _MyClassMenteeListScreenState extends State<MyClassMenteeListScreen> {
  int _unreadNotificationsCount = 0;
  final NotificationService _notificationService = NotificationService();
  late Future<List<TransactionMyClass>> classData;
  late Future<List<ParticipantMyClass>> sessionData;

  int _getClassPriority(TransactionMyClass transaction) {
    DateTime now = DateTime.now();
    DateTime startDate =
        DateTime.parse(transaction.transactionClass?.startDate ?? '');
    DateTime endDate =
        DateTime.parse(transaction.transactionClass?.endDate ?? '');
    bool isClassActive = now.isAfter(startDate) &&
        now.isBefore(endDate) &&
        transaction.paymentStatus == "Approved";
    bool isClassScheduled =
        now.isBefore(startDate) && transaction.paymentStatus == "Approved";
    bool isClassFinished =
        now.isAfter(endDate) && transaction.paymentStatus == "Approved";

    if (transaction.paymentStatus == "Rejected") {
      return 0; // Highest priority
    } else if (transaction.paymentStatus == "Pending") {
      return 1;
    } else if (transaction.paymentStatus == "Expired") {
      return 2;
    } else if (isClassActive) {
      return 3;
    } else if (isClassScheduled) {
      return 4;
    } else if (isClassFinished) {
      return 5;
    }
    return 6;
  }

  int _getSessionPriority(SessionMyClass userSessions) {
    String buttonText = "Available";

    DateTime startTime = DateTime.parse(userSessions.startTime!);
    startTime = startTime.toLocal().subtract(const Duration(hours: 7));
    DateTime endTime = DateTime.parse(userSessions.endTime!);
    endTime = endTime.toLocal().subtract(const Duration(hours: 7));

    if (userSessions.isActive == true && startTime.isAfter(DateTime.now())) {
      buttonText = "Scheduled";
    } else if (userSessions.isActive == false &&
        DateTime.now().isBefore(endTime) &&
        DateTime.now().isAfter(startTime)) {
      buttonText = "Active";
    } else if (userSessions.isActive == false &&
        DateTime.now().isAfter(endTime)) {
      buttonText = "Finished";
    }

    return _calculateSessionpriority(buttonText);
  }

  int _calculateSessionpriority(String buttonText) {
    if (buttonText == "Active") {
      return 1;
    } else if (buttonText == "Scheduled") {
      return 2;
    } else if (buttonText == "Finished") {
      return 3;
    } else {
      return 0;
    }
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
      print(e); // Handle error appropriately
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
    changeClass(widget.subMenu); // Set the initial sub-menu
    fetchData();
  }

  bool isBookingClassActive = true;
  bool isPremiumClassActive = false;
  bool isSessionActive = false;

  void changeClass(String menu) {
    setState(() {
      if (menu == "Booking Class") {
        isBookingClassActive = true;
        isPremiumClassActive = false;
        isSessionActive = false;
      } else if (menu == "Premium Class") {
        isBookingClassActive = false;
        isPremiumClassActive = true;
        isSessionActive = false;
      } else if (menu == "Session") {
        isBookingClassActive = false;
        isPremiumClassActive = false;
        isSessionActive = true;
      }
    });
  }

  Future<void> fetchData() async {
    setState(() {
      classData = BookingService().fetchUserTransactions();
      sessionData = BookingService().fetchUserSessions();
    });
  }

  int _getBookingClassCount(List<TransactionMyClass> transactions) {
    return transactions
        .where((c) =>
            _getClassPriority(c) == 0 ||
            _getClassPriority(c) == 1 ||
            _getClassPriority(c) == 2)
        .length;
  }

  int _getPremiumClassCount(List<TransactionMyClass> transactions) {
    return transactions
        .where((c) =>
            _getClassPriority(c) == 3 ||
            _getClassPriority(c) == 4 ||
            _getClassPriority(c) == 5)
        .length;
  }

  int _getSessionCount(List<ParticipantMyClass> sessions) {
    return sessions
        .where((s) =>
            _getSessionPriority(s.session!) == 1 ||
            _getSessionPriority(s.session!) == 2 ||
            _getSessionPriority(s.session!) == 3)
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
                        builder: (context) => NotificationMenteeScreen(),
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
      body: FutureBuilder<List<TransactionMyClass>>(
        future: classData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 2.0,
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final classes = snapshot.data!;
            final bookingClassCount = _getBookingClassCount(classes);
            final premiumClassCount = _getPremiumClassCount(classes);

            return FutureBuilder(
              future: sessionData,
              builder: (context, sessionSnapshot) {
                if (sessionSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height / 2.0,
                      child: const Center(child: CircularProgressIndicator()));
                } else if (sessionSnapshot.hasError) {
                  return Center(child: Text('Error: ${sessionSnapshot.error}'));
                } else if (sessionSnapshot.hasData) {
                  final List<ParticipantMyClass> sessions =
                      sessionSnapshot.data!;
                  final sessionCount = _getSessionCount(sessions);

                  return ListView(children: [
                    Column(
                      children: [
                        const SearchBarWidgetMentee(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    height: 38,
                                    decoration: isBookingClassActive
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: ColorStyle().secondaryColors,
                                          )
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color:
                                                  ColorStyle().secondaryColors,
                                            ),
                                          ),
                                    child: TextButton(
                                      onPressed: () {
                                        changeClass("Booking Class");
                                      },
                                      child: Text(
                                        "Booking Class ( $bookingClassCount )",
                                        style: FontFamily().boldText.copyWith(
                                              color: isBookingClassActive
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
                                            color: ColorStyle().secondaryColors,
                                          )
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color:
                                                  ColorStyle().secondaryColors,
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
                                            color: ColorStyle().secondaryColors,
                                          )
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color:
                                                  ColorStyle().secondaryColors,
                                            ),
                                          ),
                                    child: TextButton(
                                      onPressed: () {
                                        changeClass("Session");
                                      },
                                      child: Text(
                                        "Session ( $sessionCount )",
                                        style: FontFamily().boldText.copyWith(
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
                            isBookingClassActive
                                ? BookingClassMenteeScreen()
                                : isPremiumClassActive
                                    ? PremiumClassMenteeScreen()
                                    : isSessionActive
                                        ? MySessionBooking()
                                        : BookingClassMenteeScreen()
                          ],
                        )
                      ],
                    ),
                  ]);
                }
                return const SizedBox();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
