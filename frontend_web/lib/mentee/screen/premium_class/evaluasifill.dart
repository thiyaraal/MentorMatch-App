import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/widget/custombutton.dart';
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

class EvaluasiMenteeFillPage extends StatefulWidget {
  const EvaluasiMenteeFillPage({Key? key}) : super(key: key);

  @override
  _EvaluasiMenteeFillPageState createState() => _EvaluasiMenteeFillPageState();
}

class _EvaluasiMenteeFillPageState extends State<EvaluasiMenteeFillPage> {
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
                    //     builder: (context) => PremiumClassMenteeDetailPage(),
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
                              title: "Nama Mentor",
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
                            CustomInfoContainer(
                              title: "Akses Link Evaluasi",
                              actionWidget: Column(
                                children: [
                                  CustomButton(
                                    buttonText: "Evaluasi User Understanding",
                                    icon: Icons.link_rounded,
                                    onPressed: () {
                                      launchYouTubeLink(
                                          'https://youtu.be/yn_1SYlkqiE?si=6XaG-CpB0AI4Br02');
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  CustomButton(
                                    buttonText:
                                        "Prinsip-prinsip desain aksesibilitas",
                                    icon: Icons.link_rounded,
                                    onPressed: () {
                                      launchYouTubeLink(
                                          'https://youtu.be/yn_1SYlkqiE?si=6XaG-CpB0AI4Br02');
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CustomInfoContainer(
                              title: "Evaluasi yang telah dikerjakan",
                              icon: Icons.check_rounded,
                              actionWidget: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Materi Evaluasi : Evaluasi User Understanding",
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: EdgeInsets.all(35.0),
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Selamat atas penyelesaian Chapter 1, [Nama Mentee]! Pemahaman konsepnya sudah baik, dan analisisnya mendalam. Tetapi, tambahkan contoh atau aplikasi praktis untuk pemahaman yang lebih baik. Pastikan selalu mencantumkan sumber dan variasikan gaya penulisan. Untuk Chapter 2, fokus pada [area/topik spesifik] untuk memperdalam pemahaman. Jika ada pertanyaan, jangan ragu untuk bertanya. Bagus sekali, [Nama Mentee]! Saya yakin dengan ketekunan Anda, Anda akan berhasil di bab-bab berikutnya. Terima kasih.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Text(
                                        "Materi Evaluasi : Evaluasi User Understanding",
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: EdgeInsets.all(35.0),
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Selamat atas penyelesaian Chapter 1, [Nama Mentee]! Pemahaman konsepnya sudah baik, dan analisisnya mendalam. Tetapi, tambahkan contoh atau aplikasi praktis untuk pemahaman yang lebih baik. Pastikan selalu mencantumkan sumber dan variasikan gaya penulisan. Untuk Chapter 2, fokus pada [area/topik spesifik] untuk memperdalam pemahaman. Jika ada pertanyaan, jangan ragu untuk bertanya. Bagus sekali, [Nama Mentee]! Saya yakin dengan ketekunan Anda, Anda akan berhasil di bab-bab berikutnya. Terima kasih.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
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
