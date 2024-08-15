import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentee/model/my_class_model.dart';
import 'package:my_flutter_app/mentee/service/my_class_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class MySessionBooking extends StatefulWidget {
  const MySessionBooking({super.key});

  @override
  State<MySessionBooking> createState() => _MySessionBookingState();
}

class _MySessionBookingState extends State<MySessionBooking> {
  Future<List<ParticipantMyClass>>? _userData;

  int _getPriority(SessionMyClass userSessions) {
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

    return _calculatePriority(buttonText);
  }

  int _calculatePriority(String buttonText) {
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

  @override
  void initState() {
    super.initState();
    _userData = BookingService().fetchUserSessions();

    _userData!.then((value) {
      value.sort((a, b) {
        return _getPriority(a.session!).compareTo(_getPriority(b.session!));
      });
    });
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

//// link zoom akses///
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParticipantMyClass>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2.0,
              child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<ParticipantMyClass> participants = snapshot.data!;
          if (participants.isEmpty) {
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
                    ],
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: participants.map((participant) {
                final session = participant.session!;
                int statusButton = _getPriority(session);

                DateTime parsedJadwal = DateTime.parse(session.startTime!);
                String formattedJadwal =
                    DateFormat('dd MMMM yyyy').format(parsedJadwal);

                final DateFormat formatOutput = DateFormat("HH:mm");
                final String formattedStartTime =
                    formatOutput.format(DateTime.parse(session.startTime!));
                final String formattedEndTime =
                    formatOutput.format(DateTime.parse(session.endTime!));

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: ColorStyle().whiteColors,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          if (statusButton == 1)
                            createStatusButton(
                                "Active", ColorStyle().succesColors)
                          else if (statusButton == 2)
                            createStatusButton(
                                "Scheduled", ColorStyle().secondaryColors)
                          else if (statusButton == 3)
                            createStatusButton(
                                "Finished", ColorStyle().disableColors),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/blank_profile.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: session.mentor!.photoUrl.toString(),
                                  fit: BoxFit.cover,
                                  width: 98,
                                  height: 98,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      session.title ?? '',
                                      style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                          color: ColorStyle().blackColors),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Mentor : ${session.mentor!.name}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorStyle().disableColors),
                                    ),
                                    Text(
                                      'Jadwal : $formattedJadwal',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorStyle().disableColors),
                                    ),
                                    Text(
                                      'Jam : $formattedStartTime - $formattedEndTime',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorStyle().disableColors),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 24,
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
                                    final zoomLink = session.zoomLink ?? '';

                                    if (zoomLink.isEmpty) {
                                      showTopSnackBar(
                                          context, 'Zoom link belum tersedia');
                                    } else {
                                      _launchURL(zoomLink);
                                    }
                                  },
                                  icon: const Icon(Icons.link),
                                  label: Text(
                                    'Join Session',
                                    style: FontFamily().regularText.copyWith(
                                          color: ColorStyle().whiteColors,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
