import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

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
      backgroundColor: ColorStyle().whiteColors,
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 800,
          child: ListView(
            children: [
              Column(
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
                        "Booking Session",
                        style: FontFamily().boldText.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: ColorStyle().secondaryColors),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      "Terima kasih, Kamu telah berhasil memesan session ini. Untuk melakukan session kamu dapat melihat pada menu MyClass.",
                      style: FontFamily().regularText.copyWith(
                          color: ColorStyle().disableColors, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SizedBox(
                            width: 42.12,
                            child: Image.asset(
                              'assets/Handoff/payment.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorStyle().tertiaryColors,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 4), // Shadow position
                                ),
                              ],
                              color: Colors.white,

                              // border radius
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 12,
                                    bottom: 12.0,
                                    right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Detail Session",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors
                                              .black, // You can change the color as needed
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Nama Kelas",
                                            softWrap:
                                                true, // Memungkinkan teks pindah ke baris baru
                                            overflow: TextOverflow
                                                .visible, // Menampilkan teks yang melebihi batas tanpa memotong
                                            style:
                                                FontFamily().boldText.copyWith(
                                                      color: ColorStyle()
                                                          .primaryColors,
                                                      fontSize: 14,
                                                    ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                10), // Spasi antara teks "Nama Kelas" dan "Nama Session"
                                        Flexible(
                                          child: Text(
                                            widget.nama_session,
                                            textAlign: TextAlign.right,
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                  color: ColorStyle()
                                                      .disableColors,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, top: 8.0),
                                          child: Text(
                                            "Nama Mentor",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .primaryColors,
                                                    fontSize: 14),
                                          ),
                                        ),
                                        Text(widget.nama_mentor,
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, top: 8.0),
                                          child: Text(
                                            "Jadwal Session",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .primaryColors,
                                                    fontSize: 14),
                                          ),
                                        ),
                                        Text(widget.jadwal_session,
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, top: 8.0),
                                          child: Text(
                                            "Location",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .primaryColors,
                                                    fontSize: 14),
                                          ),
                                        ),
                                        Text('Meeting Zoom',
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButtonWidget2(
                                  title: "Lihat Session",
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MenteeHomePage(
                                          selectedMenu: "Class",
                                          subMenu:
                                              "Session", // New parameter to indicate sub-menu selection
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
