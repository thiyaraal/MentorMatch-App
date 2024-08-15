import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/mentor/model/my_class_mentor_model.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingClassMentorScreen extends StatefulWidget {
  final List<FeedbackMyClassMentor> feedbacks;
  final String locationMentoring;
  final String addressMentoring;
  final int approvedTransactionsCount;
  final List<Transaction> transactions;
  final List<LearningMaterialMentor> learningMaterial;
  final List<Evaluation> evaluation;
  final DateTime endDate;
  final DateTime startDate;
  final String schedule;
  final int maxParticipants;
  final List<String> term;
  final List<String> targetLearning;
  final String aksesLinkZoom;
  final String deskripsiKelas;
  final String classid;
  final String linkZoom;
  final String namaKelas;
  final int durationInDays;
  final AllClass userClass;

  PendingClassMentorScreen({
    Key? key,
    required this.feedbacks,
    required this.locationMentoring,
    required this.addressMentoring,
    required this.approvedTransactionsCount,
    required this.transactions,
    required this.namaKelas,
    required this.durationInDays,
    required this.endDate,
    required this.startDate,
    required this.schedule,
    required this.maxParticipants,
    required this.term,
    required this.targetLearning,
    required this.aksesLinkZoom,
    required this.deskripsiKelas,
    required this.classid,
    required this.userClass,
    required this.learningMaterial,
    required this.linkZoom,
    required this.evaluation,
  }) : super(key: key);

  @override
  State<PendingClassMentorScreen> createState() =>
      _PendingClassMentorScreenState();
}

class _PendingClassMentorScreenState extends State<PendingClassMentorScreen> {
  _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
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
                  "${widget.durationInDays} Hari",
                  style: FontFamily().regularText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.deskripsiKelas.toString(),
                  style: FontFamily().regularText,
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Periode Kelas '),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        // buat seperti ini 30 Hari ( 24 Februari - 24 Maret 2024)
                        '${widget.durationInDays} Hari ($formattedStartDate - $formattedEndDate)',

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
                      padding: const EdgeInsets.only(top: 2.0),
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
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        '${widget.maxParticipants} Orang',
                        style: FontFamily().regularText,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TittleTextField(title: 'Jumlah Mentee terdaftar'),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        '${widget.approvedTransactionsCount} Orang ',
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
                        widget.locationMentoring,
                        style: FontFamily().regularText,
                      ),
                    ),
                    Text(
                      "Lokasi : ${widget.addressMentoring == null || widget.addressMentoring!.isEmpty ? "Meeting Zoom" : widget.addressMentoring}",
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
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (widget.term.isNotEmpty)
                            ? widget.term.map<Widget>((term) {
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
                    TittleTextField(title: 'Module Pembelajaran '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (widget.targetLearning.isNotEmpty)
                            ? widget.targetLearning.map<Widget>((term) {
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
                const SizedBox(height: 12),
                Text("Aktivitas kelas belum tersedia",
                    style: FontFamily().regularText.copyWith(
                        color: ColorStyle().disableColors, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
