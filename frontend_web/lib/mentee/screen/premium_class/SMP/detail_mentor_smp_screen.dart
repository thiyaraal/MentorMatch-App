import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentee/model/category_smp_model.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/detail_class_mentor_smp_screen.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/navbaruser.dart';
import 'package:my_flutter_app/widget/profileavatar.dart';
import 'package:my_flutter_app/widget/reviewwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSMPScreen extends StatefulWidget {
  final List<TransactionSMP>? transaction;
  final List<ExperienceSMP> experiences;
  final String classid;
  final List<ClassMentorSMP>? classes;
  final String about;
  final String photoUrl;
  final String name;
  final String company;
  final String job;
  final String email;
  final String linkedin;
  final List<String> skills;
  final String location;
  final MentorSMP mentor;
  final List<MentorReviewSMP> mentorReviews;

  DetailMentorSMPScreen(
      {Key? key,
      required this.experiences,
      required this.classid,
      required this.classes,
      required this.about,
      required this.photoUrl,
      required this.name,
      required this.company,
      required this.job,
      required this.email,
      required this.linkedin,
      required this.skills,
      required this.location,
      this.transaction,
      required this.mentor,
      required this.mentorReviews})
      : super(key: key);

  @override
  State<DetailMentorSMPScreen> createState() => _DetailMentorSMPScreenState();
}

class _DetailMentorSMPScreenState extends State<DetailMentorSMPScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    imageUrl: widget.photoUrl,
                    radius: 80,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
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
                                  widget.job,
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
                                    widget.location,
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
                              widget.company,
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
                      widget.about,
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
                          final linkedlnlink = widget.linkedin ?? '';
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
                        children: widget.skills
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
                      children: widget.mentor.experiences?.map((experience) {
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
                        "Program yang ditawarkan",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xffE78938),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.classes != null &&
                              widget.classes!.isNotEmpty
                          ? Column(
                              children: widget.classes!
                                  .where((kelas) => kelas.isAvailable == true)
                                  .map((kelas) {
                                int getApprovedTransactionCount(
                                    ClassMentorSMP kelas) {
                                  int count = kelas.transactions
                                          ?.where((t) =>
                                              t.paymentStatus == "Approved")
                                          .length ??
                                      0;
                                  return count;
                                }

                                int getPendingTransactionCount(
                                    ClassMentorSMP kelas) {
                                  int count = kelas.transactions
                                          ?.where((t) =>
                                              t.paymentStatus == "Pending")
                                          .length ??
                                      0;
                                  return count;
                                }

                                int availableSlots = kelas.maxParticipants! -
                                    getApprovedTransactionCount(kelas);

                                Color buttonColor = getApprovedTransactionCount(
                                                kelas) +
                                            getPendingTransactionCount(kelas) ==
                                        kelas.maxParticipants
                                    ? Colors.grey
                                    : ColorStyle().primaryColors;

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 600,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorStyle().tertiaryColors,
                                            blurRadius: 4,
                                            spreadRadius: 4,
                                            offset: const Offset(
                                                0, 4), // Shadow position
                                          ),
                                        ],
                                        color: Colors.white,

                                        // border radius
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // "UI/UX Research and Design I",
                                              kelas.name ?? "",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                                color: const Color(0xffE78938),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${DateFormat('dd MMMM').format(DateTime.parse(kelas.startDate!))} - ${DateFormat('dd MMMM yyyy').format(DateTime.parse(kelas.endDate!))}",
                                              style: FontFamily()
                                                  .regularText
                                                  .copyWith(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(kelas.description ?? "",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: FontFamily()
                                                    .regularText
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: ColorStyle()
                                                            .disableColors)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: SizedBox(
                                                width: 150,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: const Color(
                                                        0xffE78938), // Primary color
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 34.0,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                  onPressed: availableSlots > 0
                                                      ? () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailClassMentorSMP(
                                                                addressMentoring:
                                                                    kelas.address ??
                                                                        "",
                                                                locationMentoring:
                                                                    kelas.location ??
                                                                        "",
                                                                mentorName:
                                                                    widget.name,
                                                                transaction:
                                                                    kelas.transactions ??
                                                                        [],
                                                                mentorData:
                                                                    widget
                                                                        .mentor,
                                                                classId:
                                                                    kelas.id,
                                                                classname: kelas
                                                                        .name ??
                                                                    'No Class Name',
                                                                classprice:
                                                                    kelas.price ??
                                                                        0,
                                                                classduration:
                                                                    kelas.durationInDays ??
                                                                        0,
                                                                maxParticipants:
                                                                    kelas.maxParticipants ??
                                                                        0,
                                                                endDate: DateTime
                                                                    .parse(kelas
                                                                            .endDate ??
                                                                        ''),
                                                                startDate: DateTime
                                                                    .parse(kelas
                                                                            .startDate ??
                                                                        ''),
                                                                schedule: kelas
                                                                        .schedule ??
                                                                    'No Schedule',
                                                                classDescription:
                                                                    kelas.description ??
                                                                        'No Description',
                                                                targetLearning:
                                                                    kelas
                                                                        .targetLearning,
                                                                terms:
                                                                    kelas.terms,
                                                                durationInDays:
                                                                    kelas
                                                                        .durationInDays,
                                                                price: kelas
                                                                        .price ??
                                                                    0,
                                                                location: kelas
                                                                    .location,
                                                                address: kelas
                                                                    .address,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      : () {
                                                          showTopSnackBar(
                                                              context,
                                                              'Maaf, slot kelas ini sudah penuh',
                                                              leftBarIndicatorColor:
                                                                  Colors.red);
                                                        },
                                                  child: const Text(
                                                    "Lihat Detail",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                );
                              }).toList(),
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
    );
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
