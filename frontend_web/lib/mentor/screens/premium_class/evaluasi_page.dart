import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/widget/custombutton.dart';
import 'package:my_flutter_app/widget/form.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomInfoContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? actionWidget;
  final IconData? icon;

  const CustomInfoContainer({
    required this.title,
    this.subtitle,
    this.actionWidget,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F1F1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.black,
                  size: 42,
                ),
              SizedBox(width: icon != null ? 10 : 0),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          if (subtitle != null && subtitle!.isNotEmpty)
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Text(
                  subtitle!,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          if (actionWidget != null) SizedBox(height: 20),
          if (actionWidget != null) actionWidget!,
        ],
      ),
    );
  }
}

class EvaluasiMentorPage extends StatefulWidget {
  const EvaluasiMentorPage({Key? key}) : super(key: key);

  @override
  _EvaluasiMentorPageState createState() => _EvaluasiMentorPageState();
}

class _EvaluasiMentorPageState extends State<EvaluasiMentorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 55.0),
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PremiumClassMentorDetailPage(),
                    //   ),
                    // );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Evaluasi',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(55.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomInfoContainer(
                              title: "Periode Program",
                              subtitle: "3 Bulan",
                            ),
                            CustomInfoContainer(
                              title: "Nama Mentee",
                              subtitle: "Steven Jobs",
                            ),
                            CustomInfoContainer(
                              title: "Panduan Evaluasi",
                              subtitle:
                                  "1. Evaluasi dilakukan setiap satu topik dalam program dan layanan sebagai penilaian atau pemeriksaan sistematis untuk mengevaluasi efektivitas, efisiensi, dan dampak dari suatu topik yang telah di ajarkan dalam program atau layanan.\n"
                                  "2. Tujuan evaluasi ini adalah untuk mengukur sejauh mana mentee dalam pencapaian pembelajaran, mengidentifikasi area perbaikan, dan memberikan umpan balik yang dapat digunakan untuk meningkatkan kualitas dan efisiensi pelaksanaan program atau layanan tersebut.\n"
                                  "3. Evaluasi akan di berikan oleh mentor yang membimbingan kelas dalam bentuk formulir yang akan dikirim pada saat kegiatan mentoring berlangsung (zoom meeting).\n"
                                  "4. Hasil dari evaluasi akan dikirim mentor pada halaman ini apabila mentee telah menyelesaikan dan mentor telah menilai dari jawaban yang mentee berikan.",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Link Zoom",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            CustomForm(
                              title: "Topik atau Materi",
                              subtitle: "Masukkan topik atau materi",
                            ),
                            CustomForm(
                              title: "Link Evaluasi",
                              subtitle: "Masukkan link evaluasi",
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 650,
                                  child: CustomButton(
                                    buttonText: "Kirim",
                                    onPressed: () {
                                      // Your onPressed function here
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hasil Evaluasi Mentee",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            CustomForm(
                              title: "Topik atau Materi",
                              subtitle: "Masukkan topik atau materi",
                            ),
                            CustomForm(
                              title: "Saran & Masukan dari hasil evaluasi",
                              subtitle: "Masukkan link evaluasi",
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 650,
                                  child: CustomButton(
                                    buttonText: "Kirim",
                                    onPressed: () {
                                      // Your onPressed function here
                                    },
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
            ],
          ),
        ),
      ),
    );
  }

  void launchYouTubeLink(String youtubeLink) async {
    if (await canLaunch(youtubeLink)) {
      await launch(youtubeLink);
    } else {
      throw 'Could not launch $youtubeLink';
    }
  }
}
