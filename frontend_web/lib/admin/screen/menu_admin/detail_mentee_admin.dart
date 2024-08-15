import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/model/mentee_model.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/profileavatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class DetailMenteeAdmin extends StatefulWidget {
  final Mentee menteeDetail;

  DetailMenteeAdmin({Key? key, required this.menteeDetail}) : super(key: key);

  @override
  State<DetailMenteeAdmin> createState() => _DetailMenteeAdminState();
}

class _DetailMenteeAdminState extends State<DetailMenteeAdmin> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final menteeDetail = widget.menteeDetail;
    return Scaffold(
        appBar: AppBar(
          // title: Text('Detail data mentee'),
          // make title align left
          title: Row(
            children: [
              SizedBox(width: 8),
              Text('Detail data mentee'),
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
                                imageUrl: menteeDetail.photoUrl ??
                                    '"https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"',
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menteeDetail.name ?? '',
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
                                          menteeDetail.experiences
                                                      ?.isNotEmpty ==
                                                  true
                                              ? "${menteeDetail.experiences?.firstWhere((element) => element.isCurrentJob == true).jobTitle ?? ""} at ${menteeDetail.experiences?.firstWhere((element) => element.isCurrentJob == true).company ?? ""}"
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
                                        menteeDetail.location ?? '',
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
                                menteeDetail.about ?? '',
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
                                            menteeDetail.linkedin ?? '';
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
                                "Skills",
                                style: FontFamily().boldText.copyWith(
                                    color: ColorStyle().primaryColors,
                                    fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: menteeDetail.skills
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "• Premium Kelas Yang Diikuti",
                                  style: FontFamily().boldText.copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                                Text(
                                  "total class: ${menteeDetail.transactions?.where((transaction) => transaction.paymentStatus == "Approved").length ?? 0}",
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
                              children: menteeDetail.transactions
                                      ?.where((transaction) =>
                                          transaction.paymentStatus ==
                                          "Approved")
                                      .map(
                                        (transaction) => Container(
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "# ${transaction.transactionClass?.name ?? ''}",
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
                        ),
                      ),
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
                                    "• Session Yang Diikuti",
                                    style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                        ),
                                  ),
                                  Text(
                                    "total session: ${menteeDetail.participant?.length ?? 0}",
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
                                children: menteeDetail.participant
                                        ?.map((participant) => Container(
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
                                                  "# ${participant.session?.title ?? ''}",
                                                  style: FontFamily()
                                                      .boldText
                                                      .copyWith(
                                                        color: ColorStyle()
                                                            .disableColors,
                                                        fontSize: 14,
                                                      ),
                                                ),
                                              ),
                                            ))
                                        .toList() ??
                                    [
                                      Text('No session'),
                                    ],
                              )
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
