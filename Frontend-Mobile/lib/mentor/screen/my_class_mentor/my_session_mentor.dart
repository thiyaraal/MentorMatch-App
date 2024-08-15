import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentor/model/my_class_mentor_model.dart';
import 'package:mentormatch_apps/mentor/screen/create_class_and_session/form_create_session.dart';
import 'package:mentormatch_apps/mentor/service/my_class_create_mentor_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionCreate extends StatefulWidget {
  MySessionCreate({Key? key}) : super(key: key);

  @override
  State<MySessionCreate> createState() => _MySessionCreateState();
}

class _MySessionCreateState extends State<MySessionCreate> {
  late Future<List<Session>> _sessionsFuture;

  int _getPriority(Session userSessions) {
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

    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
    if (buttonText == "Active") {
      return 1;
    } else if (buttonText == "Scheduled") {
      return 2;
    } else if (buttonText == "Full") {
      return 3;
    } else if (buttonText == "Finished") {
      return 4;
    } else if (buttonText == "Expired") {
      return 5;
    }
    return 0;
  }

  //// link zoom akses///
  _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  createStatusButton(String title, Color color) {
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

    _sessionsFuture = ListClassMentor().fetchSessionsForCurrentUser();

    /// Membuat sort sesuai dengan prioritas status
    _sessionsFuture.then((value) {
      value.sort((a, b) {
        return _getPriority(a).compareTo(_getPriority(b));
      });
      setState(() {}); // Atur ulang state setelah sorting dilakukan
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Session>>(
      future:
          _sessionsFuture, // Asumsi ini adalah Future yang Anda panggil untuk mendapatkan data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          if (snapshot.data!.isEmpty) {
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
                        'assets/Handoff/ilustrator/empty_session.png',
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
                              builder: (context) => FormCreateSessionScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.add, color: ColorStyle().whiteColors),
                        label: Text(
                          "Buat Session",
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
            child: Column(
              children: snapshot.data!.map((session) {
                int statusButton = _getPriority(session);

                DateTime parsedJadwal = DateTime.parse(session.dateTime!);
                String formattedJadwal =
                    DateFormat('dd MMMM yyyy').format(parsedJadwal);

                final DateFormat formatOutput = DateFormat("HH:mm");
                final String formattedStartTime =
                    formatOutput.format(DateTime.parse(session.startTime!));
                final String formattedEndTime =
                    formatOutput.format(DateTime.parse(session.endTime!));

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: ColorStyle().whiteColors,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (statusButton == 1)
                              createStatusButton(
                                  "Active", ColorStyle().succesColors)
                            else if (statusButton == 2)
                              createStatusButton(
                                  "Scheduled", ColorStyle().secondaryColors)
                            else if (statusButton == 3)
                              createStatusButton(
                                  "Full", ColorStyle().fullbookedColors)
                            else if (statusButton == 4)
                              createStatusButton(
                                  "Finished", ColorStyle().disableColors)
                            else if (statusButton == 5)
                              createStatusButton(
                                  "Expired", ColorStyle().errorColors),
                            const SizedBox(height: 12),
                            Text(
                              session.title!,
                              style: FontFamily().boldText.copyWith(
                                  fontSize: 14,
                                  color: ColorStyle().blackColors),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Jadwal               : ${formattedJadwal}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            ),
                            Text(
                              'Jam                    : ${formattedStartTime} - ${formattedEndTime}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            ),
                            Text(
                              'Jumlah Peserta : ${session.participant!.length} peserta',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyle().disableColors),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 150,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: ColorStyle().primaryColors,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: ColorStyle().whiteColors,
                                    ),
                                    onPressed: () {
                                      if (session.zoomLink == null ||
                                          session.zoomLink!.isEmpty) {
                                        showTopSnackBar(
                                            context, "Link Zoom belum tersedia",
                                            leftBarIndicatorColor:
                                                ColorStyle().errorColors);
                                      } else {
                                        _launchURL(session.zoomLink!);
                                      }
                                    },
                                    icon: Icon(Icons.link),
                                    label: Text('Join Session',
                                        style: FontFamily()
                                            .regularText
                                            .copyWith(
                                              color: ColorStyle().whiteColors,
                                            )),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
              }).toList(),
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
                      'assets/Handoff/ilustrator/empty_session.png',
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
                            builder: (context) => FormCreateSessionScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.add, color: ColorStyle().whiteColors),
                      label: Text(
                        "Buat Session",
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
