import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentee/model/category_smp_model.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/detail_booking_premium_class_screen.dart';
import 'package:my_flutter_app/mentee/service/bookingClassService/bookclass_model.dart';
import 'package:my_flutter_app/mentee/service/bookingClassService/bookclass_service.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class DetailClassMentorSMP extends StatefulWidget {
  final String locationMentoring;
  final String addressMentoring;
  final String mentorName;
  final List<TransactionSMP>? transaction;
  final String? classId;
  final String classname;
  final int classprice;
  final int classduration;
  final int maxParticipants;
  final DateTime endDate;
  final DateTime startDate;
  final String schedule;
  final String classDescription;
  final List<String>? targetLearning;
  final List<String>? terms;
  final int? durationInDays;
  final MentorSMP mentorData;

  final int price;
  final String? location;
  final String? address;

  DetailClassMentorSMP({
    Key? key,
    required this.locationMentoring,
    required this.addressMentoring,
    required this.classId,
    required this.classname,
    required this.classprice,
    required this.classduration,
    required this.maxParticipants,
    required this.endDate,
    required this.startDate,
    required this.schedule,
    required this.classDescription,
    required this.targetLearning,
    required this.terms,
    required this.durationInDays,
    required this.mentorData,
    required this.price,
    required this.location,
    required this.address,
    required this.transaction,
    required this.mentorName,
    // required this.currentParticipant
  }) : super(key: key);

  @override
  State<DetailClassMentorSMP> createState() => _DetailClassMentorSMPState();
}

class _DetailClassMentorSMPState extends State<DetailClassMentorSMP> {
  bool _isLoading = false;

  int getApprovedTransactionCount() {
    return widget.transaction
            ?.where((t) => t.paymentStatus == "Approved")
            .length ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    String formattedStartDate =
        DateFormat('dd MMMM yyyy').format(widget.startDate);
    String formattedEndDate = DateFormat('dd MMMM yyyy').format(widget.endDate);
    int approvedTransactions = getApprovedTransactionCount();
    int availableSlots = widget.maxParticipants - approvedTransactions;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Detail Kelas",
            style: FontFamily().boldText.copyWith(
                  color: ColorStyle().primaryColors,
                  fontSize: 18,
                ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 52.0, right: 52.0, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: widget.classname),
                      Text(
                        '(Bersertifikat)',
                        style: FontFamily().boldText.copyWith(
                              color: ColorStyle().disableColors,
                              fontSize: 18,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          widget.classDescription,
                          style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Module Pembelajaran '),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (widget.targetLearning != null &&
                                  widget.targetLearning!.isNotEmpty)
                              ? widget.targetLearning!.map<Widget>((term) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('\u2022 ',
                                          style: TextStyle(
                                              /* Your bullet point style */)),
                                      Expanded(
                                        child: Text(
                                          term,
                                          style: FontFamily()
                                              .regularText
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: ColorStyle()
                                                      .disableColors,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList()
                              : [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Tidak ada module",
                                      style: FontFamily().regularText.copyWith(
                                          fontSize: 14,
                                          color: ColorStyle().disableColors,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Periode Kelas '),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          // buat seperti ini 30 Hari ( 24 Februari - 24 Maret 2024)
                          '${widget.durationInDays} Hari ($formattedStartDate - $formattedEndDate)',

                          style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Harga Kelas'),
                      Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child:
                              // Text(
                              //   'Rp${widget.price},00',
                              //   style: FontFamily().regularText.copyWith(
                              //       fontSize: 14,
                              //       color: ColorStyle().disableColors,
                              //       fontWeight: FontWeight.w500),
                              // ),
                              CustomMoneyText(
                            amount: widget.price,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Kapasitas Kelas'),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          '${widget.maxParticipants} Orang',
                          style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Sisa Slot Mentee'),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          '$availableSlots Orang',
                          style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Hari Kelas'),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          '${widget.schedule} ',
                          style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Lokasi Kelas'),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          widget.locationMentoring,
                          style: FontFamily().regularText.copyWith(
                              fontSize: 14,
                              color: ColorStyle().disableColors,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "Lokasi : ${widget.address == null || widget.address!.isEmpty ? "Meeting Zoom" : widget.address}",
                        style: FontFamily().regularText.copyWith(
                            fontSize: 14,
                            color: ColorStyle().disableColors,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Syarat & Ketentuan Kelas'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.terms?.map<Widget>((term) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('\u2022 ',
                                        style: TextStyle(
                                            // Anda dapat menyesuaikan style dari bullet point di sini jika diperlukan
                                            )),
                                    Expanded(
                                      child: Text(
                                        term,
                                        style: FontFamily()
                                            .regularText
                                            .copyWith(
                                                fontSize: 14,
                                                color:
                                                    ColorStyle().disableColors,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList() ??
                              [
                                Text(
                                  "No target learning available",
                                  style: FontFamily().regularText.copyWith(
                                      fontSize: 14,
                                      color: ColorStyle().disableColors,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TittleTextField(title: 'Syarat Wajib Kelas'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Setiap selesai materi atau chapter, mentee wajib mengerjakan evaluais yang bisa diakases dalam platform berupa link evaluasi yang nantinya akan di review dan diberikan feedback oleh mentor',
                              style: FontFamily().regularText.copyWith(
                                  fontSize: 14,
                                  color: ColorStyle().disableColors,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('\u2022'),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Mentee hanya dapat melakukan bimbingan atau mentoring selama periode kelas berlangsung. Apabila periode kelas selesai mentee tidak dapat melakukan mentoring kepada mentor.',
                              style: FontFamily().regularText.copyWith(
                                  fontSize: 14,
                                  color: ColorStyle().disableColors,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButtonWidget(
                    onPressed: () {
                      _showDialog(context);
                    },
                    title: 'Pesan kelas',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(
                children: [
                  AlertDialog(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20), // Atur padding konten
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: ColorStyle().whiteColors,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking Class", style: FontFamily().titleText),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close_rounded,
                            color: ColorStyle().errorColors,
                          ),
                        )
                      ],
                    ),
                    content: Container(
                      width: 400, // Atur lebar konten sesuai kebutuhan
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Gunakan mainAxisSize.min agar widget Column mengikuti lebar konten
                        children: [
                          Text(
                            "Apakah kamu yakin ingin memesan kelas ini? Langkah ini akan mengamankan tempatmu, pastikan untuk memeriksa kembali detail kelas sebelum mengonfirmasi",
                            textAlign: TextAlign.center,
                            style: FontFamily().regularText.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SmallOutlinedButton(
                                style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 16),
                                height: 48,
                                width: 150,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                title: "Cancel",
                              ),
                              SmallElevatedButton2(
                                style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().whiteColors,
                                    fontSize: 16),
                                height: 48,
                                width: 150,
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    // Initialize UserPreferences if not already done.
                                    await UserPreferences.init();

                                    // Retrieve the user ID from SharedPreferences
                                    String? userId =
                                        UserPreferences.getUserId();

                                    if (userId != null) {
                                      BookingResultClass result =
                                          await bookClass(
                                              widget.classId!, userId);

                                      setState(() {
                                        _isLoading = false;
                                      });

                                      if (result.isSuccess) {
                                        int? uniqueCode = result
                                            .uniqueCode; // Here you get the uniqueCode

                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailBookingClass(
                                              durasi: widget.classduration,
                                              nama_kelas: widget.classname,
                                              nama_mentor: widget.mentorName,
                                              price: widget.price,
                                              uniqueCode: uniqueCode!,
                                            ),
                                          ),
                                          (route) => false,
                                        );
                                      } else {
                                        // tampilkan messege erro dalam bentuk pop up
                                        showTopSnackBar(
                                            context, result.message);
                                      }
                                    } else {
                                      // If userId is not found, show an error
                                      throw Exception(
                                          "Anda belum login, silahkan login terlebih dahulu");
                                    }
                                  } catch (e) {
                                    // Show a SnackBar if an exception occurs
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Error: ${e.toString()}"),
                                        backgroundColor:
                                            ColorStyle().errorColors,
                                      ),
                                    );
                                  }
                                },
                                title: "Booking",
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          );
        });
  }

  void showTopSnackBar(BuildContext context, String message) {
    Flushbar(
      backgroundColor: ColorStyle().secondaryColors,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: ColorStyle().whiteColors,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: ColorStyle().errorColors,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP, // Menampilkan di bagian atas
    ).show(context);
  }
}

class CustomMoneyText extends StatelessWidget {
  final int amount; // Nilai angka dari database

  const CustomMoneyText({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Buat formatter untuk mata uang rupiah
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');

    // Format nilai angka menjadi format mata uang
    String formattedAmount = formatter.format(amount);

    // Tampilkan teks yang sudah diformat
    return Text(
      formattedAmount,
      style: FontFamily().regularText.copyWith(
          fontSize: 14,
          color: ColorStyle().disableColors,
          fontWeight: FontWeight.w500),
    );
  }
}
