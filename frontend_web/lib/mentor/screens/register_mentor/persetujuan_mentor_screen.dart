import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/Screens/register_mentor/register_form.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/style/text.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

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
          'Syarat & Ketentuan',
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
                  title: 'Rekening Bank',
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
                        'Untuk keperluan transaksi pembayaran, pengguna diwajibkan untuk memasukkan detail rekening bank yang valid.',
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
                        'Rekening bank yang dimasukkan haruslah rekening bank aktif dan terdaftar atas nama pengguna yang terdaftar di platform kami.',
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
                        'Kami hanya menerima rekening bank dari Bank Central Asia (BCA) untuk transaksi pembayaran.',
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
                        'Pengguna bertanggung jawab penuh atas kelengkapan dan kebenaran informasi rekening bank yang disediakan.',
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
                        'Kami tidak bertanggung jawab atas kesalahan transaksi yang disebabkan oleh kelalaian atau kesalahan dalam memasukkan detail rekening bank.',
                        style: FontFamily().regularText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        // ignore: prefer_const_constructors
                                        RegisterMentorScreen()));
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
