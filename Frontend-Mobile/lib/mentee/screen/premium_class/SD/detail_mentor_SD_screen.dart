import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/detail_class_mentor_SD_screen.dart';
import 'package:mentormatch_apps/mentor/model/category_SD_model.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/experience_widget.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:mentormatch_apps/widget/navbar.dart';
import 'package:mentormatch_apps/widget/profile_avatar.dart';
import 'package:mentormatch_apps/widget/review_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMentorSDScreen extends StatefulWidget {
  //  final List<Experience> description;
  final List<TransactionSD>? transaction;
  final List<ExperienceSD> experiences;
  final String classid;
  // final int periode;
  final List<MentorReviewSD>? reviews;
  // final int price;
  final List<ClassMentorSD>? classes;
  final String about;
  final String photoUrl;
  final String name;
  final String company;
  final String job;
  final String email;
  final String linkedin;
  final List<String> skills;
  final String location;

  // final List<String> terms;
  final MentorSD mentor;
  DetailMentorSDScreen(
      {Key? key,
      required this.experiences,
      required this.classid,
      // required this.periode,
      this.reviews,
      // required this.price,
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
      // required this.description,
      // required this.terms,
      required this.mentor})
      : super(key: key);

  @override
  State<DetailMentorSDScreen> createState() => _DetailMentorSDScreenState();
}

class _DetailMentorSDScreenState extends State<DetailMentorSDScreen> {
  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka $urlString';
      }
    } catch (e) {
      throw 'URL tidak valid: $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorStyle().tertiaryColors,
          title: AppBarLogoNotif()),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/Handoff/ilustrator/background.png',
                width: double.maxFinite,
                height: 180,
                fit: BoxFit.cover,
              ),
              Transform.translate(
                offset: Offset(0.0, -120 / 2.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileAvatar(
                        imageUrl: widget.photoUrl,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.name,
                        style: FontFamily().boldText.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.work,
                                size: 16, color: ColorStyle().secondaryColors),
                            const SizedBox(width: 4),
                            Text(
                              widget.job + ' at ' + widget.company,
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
                            const SizedBox(width: 4),
                            Text(
                              widget.location,
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
                              widget.about,
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
                                      foregroundColor:
                                          ColorStyle().whiteColors),
                                  onPressed: () {
                                    final linkedlnlink = widget.linkedin ?? '';
                                    _launchURL(linkedlnlink);
                                  },
                                  icon: Icon(Icons.link),
                                  label: Text('Linkedln',
                                      style: FontFamily().regularText.copyWith(
                                            color: ColorStyle().whiteColors,
                                          )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: 'Experience',
                            color: ColorStyle().primaryColors,
                          ),
                          Column(
                            children: widget.mentor.experiences
                                    ?.map((experience) {
                                  return ExperienceWidget(
                                    role: experience.jobTitle ?? 'No Job Title',
                                    company: experience.company ?? 'No Company',
                                  );
                                }).toList() ??
                                [Text('No experiences')],
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Skills',
                          color: ColorStyle().primaryColors,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Program yang di tawarkan',
                          color: ColorStyle().primaryColors,
                        ),
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
                                      ClassMentorSD kelas) {
                                    int count = kelas.transactions
                                            ?.where((t) =>
                                                t.paymentStatus == "Approved")
                                            .length ??
                                        0;
                                    return count;
                                  }

                                  int getPendingTransactionCount(
                                      ClassMentorSD kelas) {
                                    int count = kelas.transactions
                                            ?.where((t) =>
                                                t.paymentStatus == "Pending")
                                            .length ??
                                        0;
                                    return count;
                                  }

                                  int availableSlots = kelas.maxParticipants! -
                                      getApprovedTransactionCount(kelas);

                                  Color buttonColor =
                                      getApprovedTransactionCount(kelas) +
                                                  getPendingTransactionCount(
                                                      kelas) ==
                                              kelas.maxParticipants
                                          ? Colors.grey
                                          : ColorStyle().primaryColors;

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevetadButtonWithIcon(
                                      // Asumsi typo telah diperbaiki
                                      color:
                                          buttonColor, // Terapkan warna tombol
                                      onPressed: availableSlots < 0
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailClassMentorSD(
                                                    addressMentoring:
                                                        kelas.address ?? "",
                                                    locationMentoring:
                                                        kelas.location ?? "",
                                                    mentorName: widget.name,
                                                    transaction:
                                                        kelas.transactions ??
                                                            [],
                                                    mentorData: widget.mentor,
                                                    classId: kelas.id,
                                                    classname: kelas.name ??
                                                        'No Class Name',
                                                    classprice:
                                                        kelas.price ?? 0,
                                                    classduration:
                                                        kelas.durationInDays ??
                                                            0,
                                                    maxParticipants:
                                                        kelas.maxParticipants ??
                                                            0,
                                                    endDate: DateTime.parse(
                                                        kelas.endDate ?? ''),
                                                    startDate: DateTime.parse(
                                                        kelas.startDate ?? ''),
                                                    schedule: kelas.schedule ??
                                                        'No Schedule',
                                                    classDescription:
                                                        kelas.description ??
                                                            'No Description',
                                                    targetLearning:
                                                        kelas.targetLearning,
                                                    terms: kelas.terms,
                                                    durationInDays:
                                                        kelas.durationInDays,
                                                    price: kelas.price ?? 0,
                                                    location: kelas.location,
                                                    address: kelas.address,
                                                    // Lanjutkan dengan parameter lainnya...
                                                  ),
                                                ),
                                              );
                                            }
                                          : () {
                                              showTopSnackBar(context,
                                                  'Maaf, slot kelas ini sudah penuh',
                                                  leftBarIndicatorColor:
                                                      Colors.red);
                                            },

                                      title: kelas.name ?? 'No Class Name',
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
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleProfile(
                          title: 'Review',
                          color: ColorStyle().primaryColors,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildReviewWidgets(),
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

  //////review mentor///////
  Widget buildReviewWidgets() {
    // Periksa apakah reviews ada dan tidak kosong
    if (widget.reviews != null && widget.reviews!.isNotEmpty) {
      return Column(
        children: widget.reviews!.map((review) {
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
