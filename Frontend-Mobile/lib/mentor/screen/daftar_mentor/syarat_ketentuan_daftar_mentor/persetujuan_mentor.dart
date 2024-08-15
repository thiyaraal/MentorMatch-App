import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syarat_ketentuan_daftar_mentor/persetujuan_rekening.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';

class PersetujuanMentorScreen extends StatefulWidget {
  PersetujuanMentorScreen({Key? key}) : super(key: key);

  @override
  State<PersetujuanMentorScreen> createState() =>
      _PersetujuanMentorScreenState();
}

class _PersetujuanMentorScreenState extends State<PersetujuanMentorScreen> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Persetujuan Mentor',
          style: FontFamily().titleText.copyWith(
                color: ColorStyle().primaryColors,
              ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohon periksa dan baca terlebih dahulu syarat & ketentuan yang berlaku untuk menjadi mentor pada aplikasi MentorMatch ',
                  style: FontFamily().regularText,
                ),
                const SizedBox(
                  height: 8,
                ),
                const TittleTextField(
                  title: 'Syarat & Ketentuan',
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
                        'Informasi pribadi yang diperlukan termasuk nama lengkap, alamat email, nomor telepon, dan informasi lain yang relevan.',
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
                        'Anda diharapkan untuk memberikan bimbingan dengan sebaik-baiknya, sesuai dengan bidang keahlian Anda.',
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
                        'Anda harus berkontribusi secara konsisten dalam menyusun materi pembelajaran yang berkualitas dan relevan.',
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
                        'Anda berhak mendapatkan 70% dari biaya kelas yang telah ditetapkan untuk setiap kelas premium yang Anda buat',
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
                        'Pembayaran akan diproses setelah kelas selesai dan akan masuk ke rekening bank yang Anda daftarkan pada platform.',
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
                        'Kami berhak untuk membatalkan pembayaran jika Anda tidak memenuhi tanggung jawab Anda sebagai mentor.',
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
                        'Ketidakpatuhan terhadap tanggung jawab sebagai mentor dapat mengakibatkan pemutusan hubungan kerja sebagai mentor.',
                        style: FontFamily().regularText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                      icon: Icon(
                        _isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: ColorStyle().succesColors,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Saya dengan ini menyatakan bahwa saya telah menyetujui sepenuhnya syarat dan ketentuan',
                        style: FontFamily().regularText.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle().primaryColors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _isSelected
                        ? () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PersetujuanRekeningScreen()));
                          }
                        : null, // Tidak mengizinkan klik jika radio button belum dicentang

                    child: Text(
                      'Lanjutkan',
                      style: FontFamily().boldText.copyWith(
                            color: _isSelected
                                ? ColorStyle().whiteColors
                                : ColorStyle().disableColors,
                            fontSize: 16,
                          ),
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
