import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentee/model/session_model.dart';
import 'package:my_flutter_app/mentee/screen/session/detail_booking_session_screen.dart';
import 'package:my_flutter_app/mentee/service/bookSessionService/bookSesion.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/navbaruser.dart';
import 'package:my_flutter_app/widget/profileavatar.dart';
import 'package:my_flutter_app/widget/reviewwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSessionScreen extends StatefulWidget {
  final List<SessionElement>? session;
  final MentorSession detailmentor;
  final int availableSlots;
  final int totalParticipants;
  final List<MentorReview> mentorReviews;

  DetailMentorSessionScreen(
      {Key? key,
      required this.session,
      required this.totalParticipants,
      required this.availableSlots,
      required this.detailmentor,
      required this.mentorReviews})
      : super(key: key);

  @override
  State<DetailMentorSessionScreen> createState() =>
      _DetailMentorSessionScreenState();
}

class _DetailMentorSessionScreenState extends State<DetailMentorSessionScreen> {
  bool _isLoading = false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mentorDetail = widget.detailmentor;

    DateTime? parsedJadwal;
    if (mentorDetail.session != null && mentorDetail.session!.isNotEmpty) {
      parsedJadwal = DateTime.parse(mentorDetail.session!.first.dateTime!);
    }
    final DateFormat formatOutput = DateFormat("HH:mm");
    final String formattedStartTime = formatOutput
        .format(DateTime.parse(mentorDetail.session!.first.startTime!));
    final String formattedEndTime = formatOutput
        .format(DateTime.parse(mentorDetail.session!.first.endTime!));

    String formattedJadwal = parsedJadwal != null
        ? DateFormat('dd MMMM yyyy').format(parsedJadwal)
        : "No scheduled session";

    bool _isloading = false;

    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NavbarWidgetMentee(),
      ),
      body: ListView(
        children: [
          Image.asset(
            'assets/Handoff/ilustrator/backgroud.png',
            width: double.maxFinite,
            height: 180,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFf8f0f0), // #F8F0F0
                  Colors.white,
                ],
                stops: [0.5, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 50,
                right: 50,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileAvatar(
                    imageUrl: mentorDetail.photoUrl!,
                    radius: 80,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mentorDetail.name ?? "",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black, // Text color adjusted
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.work_outline_outlined,
                                  size: 20,
                                  color: Color(0xffE78938),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  mentorDetail.experiences
                                          ?.firstWhere(
                                              (element) =>
                                                  element.isCurrentJob == true,
                                              orElse: () => Experience())
                                          .jobTitle ??
                                      '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                    color: Color(0xffE78938),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    mentorDetail.location ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.home_work_outlined,
                              size: 20,
                              color: Color(0xffE78938),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              mentorDetail.experiences
                                      ?.firstWhere(
                                          (element) =>
                                              element.isCurrentJob == true,
                                          orElse: () => Experience())
                                      .company ??
                                  '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Red and Orange Sections side by side
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.all(55.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: const Color(0xffE78938),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      mentorDetail.about ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff313030),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color(0xffE78938), // Primary color
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 34.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        onPressed: () {
                          final linkedlnlink = mentorDetail.linkedin ?? '';
                          _launchURL(linkedlnlink);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/Handoff/icon/social-icons/linkedin.png',
                              width: 20.0,
                              height: 20.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              "Linkedin",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Skill",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: const Color(0xffE78938),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: mentorDetail.skills!
                            .map((skill) => SkillCard(skill: skill))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Experience",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: const Color(0xffE78938),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: mentorDetail.experiences?.map((experience) {
                            return ExperienceWidget(
                              role: experience.jobTitle ?? 'No Job Title',
                              company: experience.company ?? 'No Company',
                            );
                          }).toList() ??
                          [const Text('No experiences')],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Review",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: const Color(0xffE78938),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // list of ReviewWidget
                    buildReviewWidgets(),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.all(55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Jadwal Session",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xffE78938),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: mentorDetail.session != null &&
                                    mentorDetail.session!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: mentorDetail.session!
                                        .where((element) =>
                                            element.isActive == true)
                                        .length,
                                    itemBuilder: (context, index) {
                                      final session = mentorDetail.session!
                                          .where((element) =>
                                              element.isActive == true)
                                          .elementAt(index);

                                      String formattedJadwal =
                                          DateFormat('dd MMM yyyy').format(
                                              DateTime.parse(
                                                  session.dateTime ?? ""));
                                      String formattedStartTime =
                                          DateFormat('HH:mm').format(
                                              DateTime.parse(
                                                  session.startTime ?? ""));
                                      String formattedEndTime =
                                          DateFormat('HH:mm').format(
                                              DateTime.parse(
                                                  session.endTime ?? ""));

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 40),
                                        child: Container(
                                          width: 600,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    ColorStyle().tertiaryColors,
                                                blurRadius: 4,
                                                spreadRadius: 4,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(32.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Icon(
                                                        Icons.tag,
                                                        size: 40,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Topic",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0xffE78938),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              session.title ??
                                                                  "",
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: true,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  // Tambah bagian ini untuk waktu, lokasi, dan slot yang tersedia
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Icon(
                                                        Icons.access_time,
                                                        size: 40,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Time",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0xffE78938),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "$formattedJadwal $formattedStartTime - $formattedEndTime",
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: true,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  const SizedBox(height: 30),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        size: 40,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Location",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0xffE78938),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Zoom Meeting",
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: true,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  const SizedBox(height: 30),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Icon(
                                                        Icons.person_add_alt_1,
                                                        size: 40,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Available Slot",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0xffE78938),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              widget
                                                                  .availableSlots
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              softWrap: true,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 40),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: SizedBox(
                                                                width: double
                                                                    .maxFinite,
                                                                child:
                                                                    TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffE78938), // Primary color
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          20.0,
                                                                      horizontal:
                                                                          34.0,
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    _showDialog(
                                                                        context,
                                                                        session
                                                                            .id
                                                                            .toString());
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "Pesan Session",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      'Belum ada program',
                                      style: FontFamily().regularText,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String sessionId) {
    final mentorDetail = widget.detailmentor;

    // Cari sesi yang sesuai dengan sessionId yang diklik
    final selectedSession = mentorDetail.session?.firstWhere(
      (session) => session.id == sessionId,
      orElse: () => SessionElement(),
    );

    DateTime? parsedJadwal;
    if (selectedSession != null) {
      parsedJadwal = DateTime.parse(selectedSession.dateTime!);
    }
    final DateFormat formatOutput = DateFormat("HH:mm");
    final String formattedStartTime =
        formatOutput.format(DateTime.parse(selectedSession!.startTime!));
    final String formattedEndTime =
        formatOutput.format(DateTime.parse(selectedSession.endTime!));

    String formattedJadwal = parsedJadwal != null
        ? DateFormat('dd MMMM yyyy').format(parsedJadwal)
        : "No scheduled session";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(
                children: [
                  AlertDialog(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20), // Atur padding konten
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: ColorStyle().whiteColors,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Booking Session", style: FontFamily().titleText),
                        const SizedBox(width: 20),
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
                      width: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Apakah kamu yakin untuk memesan session ini, Kamu dapat memesan session ini secara gratis",
                            textAlign: TextAlign.center,
                            style: FontFamily().regularText.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                          const SizedBox(height: 20),
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
                              SizedBox(
                                child: SmallElevatedButton2(
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
                                      String? userId =
                                          await UserPreferences.getUserId();
                                      if (userId != null) {
                                        var result = await bookSession(
                                            sessionId, userId);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (result.isSuccess) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailBookingSession(
                                                      nama_mentor: widget
                                                          .detailmentor.name
                                                          .toString(),
                                                      nama_session:
                                                          selectedSession.title
                                                              .toString(),
                                                      jadwal_session:
                                                          "$formattedJadwal $formattedStartTime - $formattedEndTime",
                                                    )),
                                            (Route<dynamic> route) => false,
                                          );
                                        } else {
                                          // Jika booking gagal, tampilkan pesan error
                                          throw Exception(result.message);
                                        }
                                      } else {
                                        throw Exception(
                                            "Anda belum login, silahkan login terlebih dahulu.");
                                      }
                                    } catch (e) {
                                      showTopSnackBar(context, e.toString());
                                    }
                                  },
                                  title: "Booking",
                                ),
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
                      child: const Center(
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
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: ColorStyle().errorColors,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP, // Menampilkan di bagian atas
    ).show(context);
  }

  Widget buildReviewWidgets() {
    // Periksa apakah reviews ada dan tidak kosong
    if (widget.mentorReviews != null && widget.mentorReviews!.isNotEmpty) {
      return Column(
        children: widget.mentorReviews!.map((review) {
          return ReviewWidget(
            name: review.reviewer ?? "No Name",
            review: review.content ?? "No Review",
          );
        }).toList(),
      );
    } else {
      // Jika tidak ada review, tampilkan pesan
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Belum ada review",
            style: FontFamily().regularText,
          ),
        ),
      );
    }
  }
}

class SkillCard extends StatelessWidget {
  final String skill;
  SkillCard({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorStyle().secondaryColors,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(skill,
                style: FontFamily().regularText.copyWith(
                      fontSize: 14,
                    )),
          ),
        ),
      ),
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  final String role;
  final String company;
  ExperienceWidget({Key? key, required this.role, required this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.work_outline_outlined,
              size: 20, color: ColorStyle().primaryColors),
          const SizedBox(width: 8), // Sesuaikan sesuai dengan kebutuhan Anda
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Atur sesuai kebutuhan
            children: [
              Text(role, style: FontFamily().boldText.copyWith(fontSize: 16)),
              Text(company,
                  style: FontFamily().regularText.copyWith(fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
