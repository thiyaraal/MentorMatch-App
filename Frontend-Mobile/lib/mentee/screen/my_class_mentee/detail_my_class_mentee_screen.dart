import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/model/my_class_model.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/akses_materi_my_class.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/evaluasi_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/review_mentor_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMyClassMenteeScreen extends StatefulWidget {
  final DateTime endDate;
  final DateTime startDate;
  final String schedule;
  final int maxParticipants;
  final List<String> targetLearning;
  final List<LearningMaterialMyClass> learningMaterial;
  final String mentorId;
  final String mentorPhoto;
  final int periode;
  final String mentorName;
  final String namaKelas;
  final List<String> terms;
  final String descriptionKelas;
  final String linkZoom;
  final String linkEvaluasi;
  final List<EvaluationMyClass> evaluasi;
  final ClassMyClass classData;

  DetailMyClassMenteeScreen(
      {Key? key,
      required this.endDate,
      required this.startDate,
      required this.schedule,
      required this.maxParticipants,
      required this.targetLearning,
      required this.learningMaterial,
      required this.periode,
      required this.mentorName,
      required this.namaKelas,
      required this.terms,
      required this.descriptionKelas,
      required this.linkZoom,
      required this.linkEvaluasi,
      required this.evaluasi,
      required this.classData,
      required this.mentorPhoto,
      required this.mentorId})
      : super(key: key);

  @override
  State<DetailMyClassMenteeScreen> createState() =>
      _DetailMyClassMenteeScreenState();
}

class _DetailMyClassMenteeScreenState extends State<DetailMyClassMenteeScreen> {
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
    String formattedStartDate =
        DateFormat('dd MMMM yyyy').format(widget.startDate);
    String formattedEndDate = DateFormat('dd MMMM yyyy').format(widget.endDate);
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Detail Kelas",
            style: FontFamily()
                .titleText
                .copyWith(color: ColorStyle().primaryColors),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationMenteeScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: ColorStyle().secondaryColors,
            ),
          ),
        ],
      )),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    widget.namaKelas,
                    style: FontFamily().boldText.copyWith(
                        color: ColorStyle().secondaryColors, fontSize: 24),
                  ),
                ),
                Text(
                  "${widget.periode} Hari",
                  style: FontFamily().regularText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.descriptionKelas.toString(),
                  style: FontFamily().regularText,
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Periode Kelas '),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        // buat seperti ini 30 Hari ( 24 Februari - 24 Maret 2024)
                        '${widget.periode} Hari ($formattedStartDate - $formattedEndDate)',

                        style: FontFamily().regularText,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Jadwal Hari Kelas'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.schedule,
                        style: FontFamily().regularText,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Kapasitas Kelas'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${widget.maxParticipants} Orang',
                        style: FontFamily().regularText,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Lokasi Kelas'),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        widget.classData.location.toString(),
                        style: FontFamily().regularText,
                      ),
                    ),
                    Text(
                      "Lokasi : ${widget.classData.address == null || widget.classData.address!.isEmpty ? "Meeting Zoom" : widget.classData.address}",
                      style: FontFamily().regularText,
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Module Pembelajaran '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (widget.terms != null &&
                                widget.terms!.isNotEmpty)
                            ? widget.terms!.map<Widget>((term) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '\u2022 ',
                                      style: TextStyle(
                                          /* Your bullet point style */),
                                    ),
                                    Expanded(
                                      child: Text(
                                        term,
                                        style: FontFamily().regularText,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList()
                            : [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Tidak ada module",
                                    style: FontFamily().regularText,
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Module Pembelajaran '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (widget.targetLearning != null &&
                                widget.targetLearning!.isNotEmpty)
                            ? widget.targetLearning!.map<Widget>((term) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('\u2022 ',
                                        style: TextStyle(
                                            /* Your bullet point style */)),
                                    Expanded(
                                      child: Text(
                                        term,
                                        style: FontFamily().regularText,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList()
                            : [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Tidak ada module",
                                    style: FontFamily().regularText,
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Syarat Wajib Kelas'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('\u2022'),
                        const SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: Text(
                            'Setiap selesai materi atau chapter, mentee wajib mengerjakan evaluais yang bisa diakases dalam platform berupa link evaluasi yang nantinya akan di review dan diberikan feedback oleh mentor',
                            style: FontFamily().regularText,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('\u2022'),
                        const SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: Text(
                            'Mentee hanya dapat melakukan bimbingan atau mentoring selama periode kelas berlangsung. Apabila periode kelas selesai mentee tidak dapat melakukan mentoring kepada mentor.',
                            style: FontFamily().regularText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Aktivitas Kelas",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 14),
                ),
                Text("Pilih menu dibawah ini untuk melakukan aktivitas kelas",
                    style: FontFamily().regularText),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 9.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CardMyClass(
                          messsage:
                              "Klik untuk melakukan meeting dengan mentor",
                          title: "Meeting",
                          icon: 'assets/Handoff/icon/MyClass/meeting_icon.png',
                          onTap: () {
                            if (widget.classData.location == "Offline") {
                              showTopSnackBar(
                                  context, "Kelas ini dilakukan secara offline",
                                  leftBarIndicatorColor:
                                      ColorStyle().errorColors);
                            } else {
                              if (widget.linkZoom == null ||
                                  widget.linkZoom!.isEmpty) {
                                showTopSnackBar(
                                    context, "Link Zoom belum tersedia",
                                    leftBarIndicatorColor:
                                        ColorStyle().errorColors);
                              } else {
                                _launchURL(widget.linkZoom!);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CardMyClass(
                            messsage: "Klik untuk melihat materi kelass",
                            title: "Materi",
                            icon: 'assets/Handoff/icon/MyClass/materi_icon.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MaterMyClass(
                                    learningMaterial: widget.learningMaterial,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          width: 8,
                        ),
                        CardMyClass(
                          messsage: "Klik untuk melakukan evaluasi",
                          title: "Evaluasi",
                          icon: 'assets/Handoff/icon/MyClass/evaluasi_icon.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EvaluasiMenteeScreen(
                                  evaluasi: widget.evaluasi,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CardMyClass(
                          messsage:
                              "Klik untuk memberikan review kepada mentor",
                          title: "Review",
                          icon: 'assets/Handoff/icon/MyClass/review_icon.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewMentorScreen(
                                  mentorId: widget.mentorId,
                                  mentorPhoto: widget.mentorPhoto,
                                  mentorName: widget.mentorName,
                                  classPeriode: widget.periode,
                                  className: widget.namaKelas,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
