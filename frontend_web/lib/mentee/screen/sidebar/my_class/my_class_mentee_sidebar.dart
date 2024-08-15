import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/model/my_class_model.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/my_class/booking_class_mentee_screen.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/my_class/my_session_booking_mentee_screen.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/my_class/premium_class_mentee_screen.dart';
import 'package:my_flutter_app/mentee/service/my_class_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class MyClassMentee extends StatefulWidget {
  final String initialSubMenu; // New parameter for initial sub-menu

  const MyClassMentee({
    super.key,
    this.initialSubMenu = 'Booking Class',
  });
  @override
  State<MyClassMentee> createState() => _MyClassMenteeState();
}

class _MyClassMenteeState extends State<MyClassMentee> {
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

  bool isBookingClassActive = true;
  bool isPremiumClassActive = false;
  bool isSessionActive = false;

  @override
  void initState() {
    super.initState();
    changeClass(widget.initialSubMenu);
    fetchData();
  }

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
    return FutureBuilder<List<TransactionMyClass>>(
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
              if (sessionSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: const Center(child: CircularProgressIndicator()));
              } else if (sessionSnapshot.hasError) {
                return Center(child: Text('Error: ${sessionSnapshot.error}'));
              } else if (sessionSnapshot.hasData) {
                final List<ParticipantMyClass> sessions = sessionSnapshot.data!;
                final sessionCount = _getSessionCount(sessions);

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white, // Mengatur background putih
                              border: Border(
                                bottom: BorderSide(
                                  color: isBookingClassActive
                                      ? ColorStyle()
                                          .secondaryColors // Warna border ketika aktif
                                      : Colors.transparent,
                                  width: 2, // Lebar border
                                ),
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
                                          ? ColorStyle().blackColors
                                          : ColorStyle().disableColors,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 150,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white, // Mengatur background putih
                              border: Border(
                                bottom: BorderSide(
                                  color: isPremiumClassActive
                                      ? ColorStyle()
                                          .secondaryColors // Warna border ketika aktif
                                      : Colors.transparent,
                                  width: 2, // Lebar border
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
                                          ? ColorStyle().blackColors
                                          : ColorStyle().disableColors,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 150,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white, // Mengatur background putih
                              border: Border(
                                bottom: BorderSide(
                                  color: isSessionActive
                                      ? ColorStyle()
                                          .secondaryColors // Warna border ketika aktif
                                      : Colors.transparent,
                                  width: 2, // Lebar border
                                ),
                              ),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  changeClass("Session");
                                },
                                child: Text("Session ( $sessionCount )",
                                    style: FontFamily().boldText.copyWith(
                                        color: isSessionActive
                                            ? ColorStyle().blackColors
                                            : ColorStyle().disableColors))),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          isBookingClassActive
                              ? const BookingClassMenteeScreen()
                              : isPremiumClassActive
                                  ? PremiumClassMenteeScreen()
                                  : isSessionActive
                                      ? MySessionBooking()
                                      : const BookingClassMenteeScreen()
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Text('No data available');
              }
            },
          );
        }
        return const Center(
          child: Text('Kamu belum memiliki kelas'),
        );
      },
    );
  }
}
