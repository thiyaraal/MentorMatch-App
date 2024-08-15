import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/mentor_model.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/mentor_review_list.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/profileavatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class DetailMentorAdmin extends StatefulWidget {
  final Mentor mentorDetail;

  DetailMentorAdmin({Key? key, required this.mentorDetail}) : super(key: key);

  @override
  State<DetailMentorAdmin> createState() => _DetailMentorAdminState();
}

class _DetailMentorAdminState extends State<DetailMentorAdmin> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mentorDetail = widget.mentorDetail;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(width: 8),
              Text('Detail data mentor'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorStyle().tertiaryColors,
                          width: 2,
                        ),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ProfileAvatar(
                                imageUrl: mentorDetail.photoUrl ??
                                    "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mentorDetail.name ?? "",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Icon(Icons.work,
                                          color: ColorStyle().primaryColors),
                                      SizedBox(width: 8),
                                      Text(
                                          mentorDetail.experiences
                                                      ?.isNotEmpty ==
                                                  true
                                              ? "${mentorDetail.experiences?.firstWhere((element) => element.isCurrentJob == true).jobTitle ?? ""} at ${mentorDetail.experiences?.firstWhere((element) => element.isCurrentJob == true).company ?? ""}"
                                              : "not available",
                                          style: FontFamily().regularText),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: ColorStyle().primaryColors),
                                      SizedBox(width: 8),
                                      Text(
                                        mentorDetail.location ?? "",
                                        style: FontFamily().regularText,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorStyle().tertiaryColors,
                          width: 2,
                        ),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• Detail Informasi Profile",
                                style: FontFamily().boldText.copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                "About",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                mentorDetail.about ?? "",
                                style: FontFamily().regularText,
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12.0, top: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
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
                                            mentorDetail.linkedin ?? '';
                                        _launchURL(linkedlnlink);
                                      },
                                      icon: Icon(Icons.link),
                                      label: Text('Linkedln',
                                          style: FontFamily()
                                              .regularText
                                              .copyWith(
                                                color: ColorStyle().whiteColors,
                                              )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                "Experience",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: mentorDetail.experiences
                                            ?.where((experience) =>
                                                experience.isCurrentJob ==
                                                false)
                                            .map((experience) {
                                          return ExperienceWidget(
                                            role: experience.jobTitle ??
                                                'No Job Title',
                                            company: experience.company ??
                                                'No Company',
                                          );
                                        }).toList() ??
                                        [Text('No experiences')],
                                  )
                                ],
                              ),
                              SizedBox(height: 24),
                              Text(
                                "Skills",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: mentorDetail.skills
                                        ?.map((skill) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: SkillCard(
                                                skill: skill,
                                              ),
                                            ))
                                        .toList() ??
                                    [
                                      Text('No skills'),
                                    ],
                              ),
                              SizedBox(height: 24),
                              Text(
                                "Review",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // "150 Review dari mentee",
                                    "${mentorDetail.mentorReviews?.length ?? 0} Review dari mentee",
                                    style: FontFamily().boldText.copyWith(
                                        color: ColorStyle().disableColors,
                                        fontSize: 14),
                                  ),
                                  // textButton "lihat"
                                  TextButton(
                                    // onPressed: () {},
                                    // naviagte to MentorReviewList
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MentorReviewList(
                                                  mentorReviews: mentorDetail
                                                          .mentorReviews ??
                                                      []),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Lihat",
                                      style: FontFamily().boldText.copyWith(
                                          color: ColorStyle().primaryColors,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorStyle().tertiaryColors,
                          width: 2,
                        ),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "• Premium Kelas",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                        ),
                                  ),
                                  Text(
                                    "total class: ${mentorDetail.mentorClass?.where((mentorClass) => mentorClass.isVerified == true).length ?? 0}",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                          color: ColorStyle().disableColors,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: mentorDetail.mentorClass
                                        ?.where((mentorClass) =>
                                            mentorClass.isVerified == true)
                                        .map(
                                          (mentorClass) => Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorStyle()
                                                      .tertiaryColors, // Warna border dapat disesuaikan
                                                  width: 2.0, // Lebar border
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "# ${
                                                // class name
                                                mentorClass.name ?? ""}",
                                                style: FontFamily()
                                                    .boldText
                                                    .copyWith(
                                                      color: ColorStyle()
                                                          .disableColors,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList() ??
                                    [
                                      Text('No class'),
                                    ],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorStyle().tertiaryColors,
                          width: 2,
                        ),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "• Session",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                        ),
                                  ),
                                  Text(
                                    "total session: ${mentorDetail.session?.length ?? 0}",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                          color: ColorStyle().disableColors,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: mentorDetail.session
                                        ?.map(
                                          (session) => Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorStyle()
                                                      .tertiaryColors, // Warna border dapat disesuaikan
                                                  width: 2.0, // Lebar border
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "# ${session.title ?? ""}",
                                                style: FontFamily()
                                                    .boldText
                                                    .copyWith(
                                                      color: ColorStyle()
                                                          .disableColors,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList() ??
                                    [
                                      Text('No session'),
                                    ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SkillCard extends StatefulWidget {
  final String skill;
  SkillCard({Key? key, required this.skill}) : super(key: key);

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
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
            child: Text(widget.skill, style: FontFamily().regularText),
          ),
        ),
      ),
    );
  }
}

class ExperienceWidget extends StatefulWidget {
  final String role;
  final String company;
  ExperienceWidget({Key? key, required this.role, required this.company})
      : super(key: key);

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.work_outline_outlined,
              size: 16, color: ColorStyle().primaryColors),
          SizedBox(width: 8), // Sesuaikan sesuai dengan kebutuhan Anda
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Atur sesuai kebutuhan
            children: [
              Text(widget.role, style: FontFamily().boldText),
              Text(widget.company, style: FontFamily().regularText),
            ],
          )
        ],
      ),
    );
  }
}
