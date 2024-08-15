import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class PanduanMembuatPremiumClas extends StatefulWidget {
  PanduanMembuatPremiumClas({Key? key}) : super(key: key);

  @override
  State<PanduanMembuatPremiumClas> createState() =>
      _PanduanMembuatPremiumClasState();
}

class _PanduanMembuatPremiumClasState extends State<PanduanMembuatPremiumClas> {
  final List<String> daftarSyarat = [
    "Mentor harus memiliki tanggung jawab dalam tugas dan perannya sebagai mentor kepada mentee.",
    "Mentor mampu memberikan solusi atas kendala atau hambatan yang dihadapi mentee ketika proses mentoring.",
    "Dalam Deskripsi kelas mentor di wajib kan membuat hari apa saja kelas berlangsung.",
    "Mentor dapat membuat kelas secara online-offline apabila domisili dengan mentee memungkinkan.",
    "Mentor wajib memberikan evaluasi kepada mentee sebagai bahan tolak ukur dalam pencapain mentee.",
    "Pembuatan kelas premium akan membutuhkan verifikasi oleh admin terlebih dahulu.",
    "Mentoring secar aonline akan diselenggarakan melalui meeting zoom yang akan diberikan oleh pihak admin setelah kelas di verifikasi.",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Syarat & Ketentuan Premium Class',
              style: FontFamily().regularText.copyWith(
                    fontSize: 16,
                    color: ColorStyle().primaryColors,
                  )),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Syarat & Ketentuan Membuat Kelas Premium",
                    style: FontFamily().boldText.copyWith(
                          fontSize: 24,
                          color: ColorStyle().secondaryColors,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Harap baca syarat dan ketentuan membuat kelas premium secara teliti untuk menghindari kesalahan dalam proses pembuatan kelas',
                    style: FontFamily().regularText.copyWith(
                      color: ColorStyle().errorColors
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 12),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: daftarSyarat.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String val = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "${idx + 1}. $val",
                                style: FontFamily().regularText,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
