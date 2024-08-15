import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/detail_booking_premium_class_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';

class RincianKegiatanMenteeScreen extends StatefulWidget {
  RincianKegiatanMenteeScreen({Key? key}) : super(key: key);

  @override
  State<RincianKegiatanMenteeScreen> createState() => _RincianKegiatanMenteeScreenState();
}

class _RincianKegiatanMenteeScreenState extends State<RincianKegiatanMenteeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
             onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationMenteeScreen(),
                  ),
                );
              },
            icon: Icon(
              Icons.arrow_back,
              color: ColorStyle().secondaryColors,
            ),
            label: Text(
              "Rincian Kegiatan",
              style: FontFamily()
                  .titleText
                  .copyWith(color: ColorStyle().primaryColors),
            ),
          ),
          IconButton(
            onPressed: () {},
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
                Text(
                  "UI/UX Design Research & Design",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                Text(
                  'Kelas UI/UX Research & Design ini akan berjalan selama 3 bulan sesuai dengan syarat & ketentuan yang berlaku. Modul pembelajaran akan diterima setiap meeting zoom berlangsung. Mentee akan mendapatkan modul pembelajaran yang dikirim langsung oleh mentor. Mentee dapat melakukan mentoring secara online dan offline  sesuai dengan syarat & ketentuan yang berlaku. Pada setiap topik atau materi mentee akan mengerjakan evaluasi yang akan di review oleh mentor pada aplikasi MentirMatch.',
                  style: FontFamily().regularText,
                ),
                SizedBox(height: 24),
                Text(
                  "Syrarat & Ketentuan",
                  style: FontFamily().boldText.copyWith(
                      color: ColorStyle().primaryColors, fontSize: 16),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '1. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        style: FontFamily().regularText,
                        text: 'Mahasiswa semester 1-7\n',
                      ),
                      TextSpan(
                        text: '2. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        style: FontFamily().regularText,
                        text:
                            'Mempunyai Komitmen untuk belajar secara serius\n',
                      ),
                      TextSpan(
                        text: '3. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        style: FontFamily().regularText,
                        text:
                            'Kelas berlangsung selama 4 kali dalam seminggu\n',
                      ),
                      TextSpan(
                        text: '4. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        style: FontFamily().regularText,
                        text:
                            'Dapat melakukan mentoring secara offline apabila jarak rumah dekat\n',
                      ),
                      TextSpan(
                        text: '5. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        style: FontFamily().regularText,
                        text:
                            'Wajib melakukan evaluasi setelah menyelesaikan 1 materi dan seterusnya sampai selesai\n',
                      ),
                      TextSpan(
                        text: '6. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        text:
                            'Mentee akan mendapat modul pembelajaran dari mentor ketika zoom meeting\n',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        text: '7. ',
                        style: FontFamily().regularText,
                      ),
                      TextSpan(
                        style: FontFamily().regularText,
                        text:
                            'Memiliki Laptop dengan spesifikasi minimal (Prosesor i3/i5, Storage tersisa 160Gb, RAM Minimum 8Gb)\n',
                      ),
                    ],
                  ),
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    _showDialog(context);
                  },
                  title: "IDR 1.000.000,00",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: ColorStyle().whiteColors,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Booking Class", style: FontFamily().titleText),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close_sharp, color: ColorStyle().errorColors,),
            )
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            "Apakah Kamu yakin untuk memesan Premium Class ini?",
            textAlign: TextAlign.center,
            style: FontFamily().regularText,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              SmallOutlinedButton(
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().primaryColors, fontSize: 12),
                height: 48,
                width: 152,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: "Cancel",
              ),
              SizedBox(width: 8),
              SmallElevatedButton(
                style: FontFamily()
                    .regularText
                    .copyWith(color: ColorStyle().whiteColors, fontSize: 12),
                height: 48,
                width: 152,
                onPressed: () {
                //  Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => DetailBookingPremiumClass(),
                //       ),
                //     );
                },
                title: "Booking",
              ),
            ],
          ),
        ],
      );
    },
  );
}
