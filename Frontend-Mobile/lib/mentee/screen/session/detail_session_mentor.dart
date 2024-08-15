// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/session/detail_booking_session_screen.dart';
import 'package:mentormatch_apps/mentee/service/bookSessionService/bookSesion.dart';
import 'package:mentormatch_apps/mentor/model/session_model.dart';
import 'package:mentormatch_apps/preferences/%20preferences_helper.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSessionsNew extends StatefulWidget {
  // final String sessionsid;
  final List<SessionData>? session;

  final MentorSession detailmentor;
  final int availableSlots;
  final int totalParticipants;
  final List<MentorReview> mentorReviews;
  DetailMentorSessionsNew({
    Key? key,
    required this.session,
    required this.totalParticipants,
    required this.availableSlots,
    required this.detailmentor,
    required this.mentorReviews,
  }) : super(key: key);
  @override
  State<DetailMentorSessionsNew> createState() =>
      _DetailMentorSessionsNewState();
}

class _DetailMentorSessionsNewState extends State<DetailMentorSessionsNew> {
  bool _isLoading = false;
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
    final mentorDetail = widget.detailmentor;

    // Parse the first session's date-time if it exists
    DateTime? parsedJadwal;
    if (mentorDetail.session != null && mentorDetail.session!.isNotEmpty) {
      parsedJadwal = DateTime.parse(mentorDetail.session!.first.dateTime!);
    }
    final DateFormat formatOutput = DateFormat("HH:mm");
    final String formattedStartTime = formatOutput
        .format(DateTime.parse(mentorDetail.session!.first.startTime!));
    final String formattedEndTime = formatOutput
        .format(DateTime.parse(mentorDetail.session!.first.endTime!));

    // Format the first session's date-time to the desired format
    String formattedJadwal = parsedJadwal != null
        ? DateFormat('dd MMMM yyyy').format(parsedJadwal)
        : "No scheduled session";

//company yang iscurrent
    String company = mentorDetail.experiences
            ?.firstWhere((experience) => experience.isCurrentJob == true)
            .company ??
        'No Company';
    String jobTitle = mentorDetail.experiences
            ?.firstWhere((experience) => experience.isCurrentJob == true)
            .jobTitle ??
        'No Job Title';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyle().tertiaryColors,
        title: AppBarLogoNotif(),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/Handoff/ilustrator/background.png',
                width: double.maxFinite,
                height: 180,
                fit: BoxFit.cover,
              ),
              Transform.translate(
                offset: const Offset(0.0, -60.0),
                child: Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        imageUrl: widget.detailmentor.photoUrl,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.detailmentor.name.toString(),
                        style: FontFamily().boldText.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.work,
                                size: 16, color: ColorStyle().secondaryColors),
                            const SizedBox(width: 4),
                            Text(
                              jobTitle + ' at ' + company,
                              style: FontFamily().regularText,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: ColorStyle().secondaryColors),
                            const SizedBox(width: 2),
                            Text(
                              widget.detailmentor.location ?? 'No Location',
                              style: FontFamily().regularText,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: 'About',
                            color: ColorStyle().primaryColors,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              widget.detailmentor.about ?? 'No About',
                              style: FontFamily().regularText,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 12.0, top: 8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorStyle().primaryColors,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorStyle().whiteColors,
                                  ),
                                  onPressed: () {
                                    final linkedlnlink =
                                        widget.detailmentor.linkedin;
                                    _launchURL(linkedlnlink.toString());
                                  },
                                  icon: const Icon(Icons.link),
                                  label: Text('Linkedln',
                                      style: FontFamily().regularText.copyWith(
                                            color: ColorStyle().whiteColors,
                                          )),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleProfile(
                                title: 'Experience',
                                color: ColorStyle().primaryColors,
                              ),
                              Column(
                                children: widget.detailmentor.experiences
                                        ?.map((experience) {
                                      return ExperienceWidget(
                                        role: experience.jobTitle ??
                                            'No Job Title',
                                        company:
                                            experience.company ?? 'No Company',
                                      );
                                    }).toList() ??
                                    [const Text('No experiences')],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TitleProfile(
                              title: 'Skills',
                              color: ColorStyle().primaryColors,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: widget.detailmentor.skills!
                                  .map((skill) => SkillCard(skill: skill))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            padding: const EdgeInsets.all(25),
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
                                          itemCount:
                                              mentorDetail.session!.length,
                                          itemBuilder: (context, index) {
                                            final session =
                                                mentorDetail.session![index];

                                            // Parse the session date-time
                                            final DateTime sessionDate =
                                                DateTime.parse(
                                                    session.dateTime ?? "");
                                            final DateTime currentDate =
                                                DateTime.now();

                                            // Filter out sessions with a date-time that has passed
                                            if (sessionDate
                                                .isBefore(currentDate)) {
                                              return const SizedBox.shrink();
                                            }

                                            String formattedJadwal =
                                                DateFormat('dd MMM yyyy')
                                                    .format(sessionDate);
                                            String formattedStartTime =
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(
                                                        session.startTime ??
                                                            ""));
                                            String formattedEndTime =
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(
                                                        session.endTime ?? ""));

                                            // Compute total participants and available slots for each session
                                            int totalParticipants =
                                                session.participant?.length ??
                                                    0;
                                            int availableSlots =
                                                (session.maxParticipants ?? 0) -
                                                    totalParticipants;

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 40),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorStyle()
                                                          .tertiaryColors,
                                                      blurRadius: 4,
                                                      spreadRadius: 4,
                                                      offset:
                                                          const Offset(0, 4),
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      32.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 24.0,
                                                                left: 12,
                                                                bottom: 12.0,
                                                                right: 12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "Jadwal Session",
                                                                style: FontFamily()
                                                                    .titleText
                                                                    .copyWith(
                                                                      color: ColorStyle()
                                                                          .primaryColors,
                                                                    ),
                                                              ),
                                                            ),
                                                            JadwalSessionWidget(
                                                              icon:
                                                                  Icons.comment,
                                                              title1: "topic",
                                                              title2: session
                                                                  .title
                                                                  .toString(),
                                                            ),
                                                            JadwalSessionWidget(
                                                              icon: Icons
                                                                  .access_time_outlined,
                                                              title1: "time",
                                                              title2:
                                                                  "$formattedJadwal $formattedStartTime - $formattedEndTime",
                                                            ),
                                                            const JadwalSessionWidget(
                                                              icon: Icons
                                                                  .location_on_outlined,
                                                              title1:
                                                                  "location",
                                                              title2:
                                                                  "Meeting Zoom",
                                                            ),
                                                            JadwalSessionWidget(
                                                              icon: Icons
                                                                  .people_alt_outlined,
                                                              title1:
                                                                  "Total Participants",
                                                              title2:
                                                                  totalParticipants
                                                                      .toString(),
                                                            ),
                                                            JadwalSessionWidget(
                                                              icon: Icons
                                                                  .chair_alt,
                                                              title1:
                                                                  "Available Slots",
                                                              title2:
                                                                  availableSlots
                                                                      .toString(),
                                                            ),
                                                            const SizedBox(
                                                                height: 24),
                                                            ElevatedButtonWidget(
                                                              title:
                                                                  "Pesan Session",
                                                              onPressed: () {
                                                                _showDialog(
                                                                    context,
                                                                    session.id
                                                                        .toString());
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                    ],
                  ),
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

    // Find the session that matches the sessionId
    final selectedSession = mentorDetail.session?.firstWhere(
        (session) => session.id == sessionId,
        orElse: () => SessionData());

    if (selectedSession == null) {
      showTopSnackBar(context, 'Session not found');
      return;
    }

    DateTime? parsedJadwal;
    if (selectedSession.dateTime != null) {
      parsedJadwal = DateTime.parse(selectedSession.dateTime!);
    }
    final DateFormat formatOutput = DateFormat("HH:mm");
    final String formattedStartTime =
        formatOutput.format(DateTime.parse(selectedSession.startTime!));
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: ColorStyle().whiteColors,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Booking Sessions", style: FontFamily().titleText),
                      const SizedBox(width: 20),
                      Expanded(
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close_rounded,
                            color: ColorStyle().errorColors,
                          ),
                        ),
                      )
                    ],
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SingleChildScrollView(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SmallOutlinedButton(
                                  style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().primaryColors,
                                      fontSize: 12),
                                  height: 40,
                                  width: 112,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  title: "Cancel",
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: SmallElevatedButton(
                                  style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().whiteColors,
                                      fontSize: 12),
                                  height: 40,
                                  width: 112,
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
                                                          selectedSession
                                                                  .title ??
                                                              'No Title',
                                                      jadwal_session:
                                                          formattedJadwal +
                                                              " " +
                                                              formattedStartTime +
                                                              " - " +
                                                              formattedEndTime,
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
                                      setState(() {
                                        _isLoading = false;
                                      });
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
      },
    );
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
