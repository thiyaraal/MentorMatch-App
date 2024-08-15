import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/detail_my_class_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/payment_error_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/payment_expired_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/payment_pending_screen.dart';
import 'package:mentormatch_apps/mentor/service/my_class_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class BookingClassMenteeScreen extends StatefulWidget {
  const BookingClassMenteeScreen({super.key});

  @override
  State<BookingClassMenteeScreen> createState() =>
      _BookingClassMenteeScreenState();
}

class _BookingClassMenteeScreenState extends State<BookingClassMenteeScreen> {
  Future<List<TransactionMyClass>>? _userData;

  int getClassStatusPriority(TransactionMyClass transaction) {
    if (transaction.paymentStatus == "Rejected") {
      return 0; // Highest priority
    } else if (transaction.paymentStatus == "Pending") {
      return 1;
    } else if (transaction.paymentStatus == "Expired") {
      return 2;
    }
    return 3;
  }

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserTransactions().then((transactions) {
      transactions = transactions.where((transaction) {
        return transaction.paymentStatus == "Rejected" ||
            transaction.paymentStatus == "Pending" ||
            transaction.paymentStatus == "Expired";
      }).toList();
      transactions.sort((a, b) =>
          getClassStatusPriority(a).compareTo(getClassStatusPriority(b)));
      return transactions;
    });
  }

// Helper function to create a styled button
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
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionMyClass>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2.0,
              child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final List<TransactionMyClass> classBooking = snapshot.data!;
          if (classBooking.isEmpty) {
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
                children: classBooking.map((data) {
                  int statusButton = getClassStatusPriority(data);
                  final classData = data.transactionClass!;
                  return GestureDetector(
                    onTap: () {
                      if (statusButton == 0) {
                        // Rejected
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentErrorScreenMentee(
                              classname: classData.name ?? '',
                              rejectReason: data.rejectReason.toString(),
                              price: classData.price ?? 0,
                              uniqueId: data.uniqueCode ?? 0,
                            ),
                          ),
                        );
                      } else if (statusButton == 1) {
                        // Pending
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPendingScreenMentee(
                              classname: classData.name ?? '',
                              rejectReason: data.rejectReason.toString(),
                              price: classData.price ?? 0,
                              uniqueId: data.uniqueCode ?? 0,
                            ),
                          ),
                        );
                      } else if (statusButton == 2) {
                        // Expired
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentExpiredScreenMentee(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMyClassMenteeScreen(
                              learningMaterial:
                                  classData.learningMaterial ?? [],
                              endDate: DateTime.parse(classData.endDate ?? ''),
                              startDate:
                                  DateTime.parse(classData.startDate ?? ''),
                              targetLearning: classData.targetLearning ?? [],
                              maxParticipants: classData.maxParticipants ?? 0,
                              schedule: classData.schedule ?? '',
                              mentorId: classData.mentorId ?? '',
                              mentorPhoto: classData.mentor!.photoUrl ?? '',
                              classData: classData,
                              descriptionKelas:
                                  classData.description.toString(),
                              terms: classData.terms ?? [],
                              evaluasi: classData.evaluations ?? [],
                              linkEvaluasi: classData.zoomLink ?? '',
                              mentorName: classData.mentor!.name ?? '',
                              linkZoom: classData.zoomLink ?? '',
                              namaKelas: classData.name ?? '',
                              periode: classData.durationInDays ?? 0,
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              if (statusButton == 0)
                                createStatusButton(
                                    "Rejected", ColorStyle().errorColors)
                              else if (statusButton == 1)
                                createStatusButton(
                                    "Pending", ColorStyle().pendingColors)
                              else if (statusButton == 2)
                                createStatusButton(
                                    "Expired", ColorStyle().blackColors),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          classData.mentor!.photoUrl.toString(),
                                      fit: BoxFit.cover,
                                      width: 98,
                                      height: 98,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          classData.name ?? '',
                                          style: FontFamily().boldText.copyWith(
                                              fontSize: 14,
                                              color: ColorStyle().blackColors),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                            'Mentor : ${classData.mentor!.name}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: ColorStyle()
                                                    .disableColors)),
                                        Text(
                                            'Durasi : ${classData.durationInDays} Hari',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: ColorStyle()
                                                    .disableColors)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
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
      },
    );
  }
}
