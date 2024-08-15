import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInfoContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? actionWidget;

  const CustomInfoContainer({
    required this.title,
    this.subtitle,
    this.actionWidget,
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
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 20),
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

class EvaluasiMenteeEmptyPage extends StatefulWidget {
  const EvaluasiMenteeEmptyPage({Key? key}) : super(key: key);

  @override
  _EvaluasiMenteeEmptyPageState createState() =>
      _EvaluasiMenteeEmptyPageState();
}

class _EvaluasiMenteeEmptyPageState extends State<EvaluasiMenteeEmptyPage> {
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
                    //       builder: (context) => PremiumClassMenteeDetailPage()),
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
                            SizedBox(height: 55),
                            Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/Handoff/ilustrator/learn_by_online.png',
                                    width: 500,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Kamu Belum Memiliki Evaluasi",
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
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
}
