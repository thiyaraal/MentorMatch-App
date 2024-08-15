import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class DetailBookingSession extends StatefulWidget {
  final String nama_mentor;
  final String jadwal_session;
  final String nama_session;

  DetailBookingSession({
    Key? key,
    required this.nama_mentor,
    required this.nama_session,
    required this.jadwal_session,
  }) : super(key: key);

  @override
  State<DetailBookingSession> createState() => _DetailBookingSessionState();
}

class _DetailBookingSessionState extends State<DetailBookingSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    left: 24.0,
                    right: 8.0,
                  ),
                  child: Text(
                    "Sukses Booking\nSession!",
                    style: FontFamily().boldText.copyWith(
                        fontSize: 24, color: ColorStyle().secondaryColors),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
                child: Text(
                  "Kamu telah berhasil memesan session ini. Untuk melakukan session kamu dapat melihat pada menu MyClass",
                  style: FontFamily().regularText.copyWith(fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 24.0, right: 24.0, bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: ColorStyle().tertiaryColors,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    // box shadow

                    boxShadow: [
                      BoxShadow(
                        color: ColorStyle().blackColors.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 12,
                          bottom: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Text(
                                "Nama Session",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 14),
                              ),
                            ),
                            Text(widget.nama_session,
                                style: FontFamily().regularText),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Text(
                                "Nama Mentor",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 14),
                              ),
                            ),
                            Text(widget.nama_mentor,
                                style: FontFamily().regularText),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Text(
                                "Jadwal Session",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().secondaryColors,
                                    fontSize: 14),
                              ),
                            ),
                            Text(widget.jadwal_session.toString(),
                                style: FontFamily().regularText),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButtonWidget(
                  title: "Lihat Jadwal Session",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavbarMenteeScreen(
                                activeScreen: 1,
                                subMenu: "Session",
                              )),
                      (Route<dynamic> route) =>
                          false, // Remove all routes until the new route
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
