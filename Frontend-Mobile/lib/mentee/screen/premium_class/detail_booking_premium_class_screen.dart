import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';

class DetailBookingClass extends StatefulWidget {
  final int uniqueCode;
  final int price;
  final String nama_mentor;
  final int durasi;
  final String nama_kelas;

  DetailBookingClass(
      {Key? key,
      required this.price,
      required this.nama_mentor,
      required this.durasi,
      required this.nama_kelas,
      required this.uniqueCode})
      : super(key: key);

  @override
  State<DetailBookingClass> createState() => _DetailBookingClassState();
}

class _DetailBookingClassState extends State<DetailBookingClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 12.0,
              right: 12.0,
            ),
            child: Container(
              height: 160,
              child: Image.asset(
                "assets/Handoff/ilustrator/payment-success.png",
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorStyle().tertiaryColors,
                          blurRadius: 4,
                          spreadRadius: 4,
                          offset: Offset(0, 4), // Shadow position
                        ),
                      ],
                      color: Colors.white,

                      // border radius
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 12,
                          bottom: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/Handoff/logo/LogoMobile.png',
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Berhasil Booking Kelas !",
                                style: FontFamily().boldText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorStyle().succesColors),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Terima kasih telah melakukan booking kelas dengan kami. Pesanan Anda telah diterima dengan baik. Namun, untuk mengonfirmasi keikutsertaan Anda, pembayaran harus dilakukan.",
                              style: FontFamily().regularText.copyWith(
                                    color: ColorStyle().disableColors,
                                    fontSize: 12,
                                  ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          height: 40,
                                          width: 40,
                                          'assets/Handoff/icon/MyClass/money_icon.png',
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "${NumberFormat.currency(locale: 'id', symbol: 'Rp').format(widget.price + widget.uniqueCode)}",
                                          style: FontFamily().boldText.copyWith(
                                              color:
                                                  ColorStyle().secondaryColors,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Nama Kelas",
                              style: FontFamily().boldText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                            ),
                            Text(
                              widget.nama_kelas,
                              style: FontFamily().regularText.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorStyle().disableColors,
                                    fontSize: 14,
                                  ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Nama Mentor",
                              style: FontFamily().boldText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                            ),
                            Text(
                              widget.nama_mentor,
                              style: FontFamily().regularText.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorStyle().disableColors,
                                    fontSize: 14,
                                  ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Periode Kelas",
                              style: FontFamily().boldText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                            ),
                            Text(
                              '${widget.durasi} Hari',
                              style: FontFamily().regularText.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorStyle().disableColors,
                                    fontSize: 14,
                                  ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "Metode Pembayaran",
                              style: FontFamily().boldText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: ColorStyle().primaryColors,
                                  ),
                            ),
                            Text(
                              "BANK BCA",
                              style: FontFamily().boldText.copyWith(
                                    fontSize: 14,
                                    color: ColorStyle().primaryColors,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00000001234567890',
                                  style: FontFamily().regularText.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorStyle().disableColors,
                                        fontSize: 14,
                                      ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Menyalin teks ke clipboard
                                    Clipboard.setData(const ClipboardData(
                                        text: '00000001234567890'));

                                    // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                    showTopSnackBar(
                                        context, 'Teks telah disalin');
                                  },
                                  icon: const Icon(Icons.copy),
                                )
                              ],
                            ),
                            Text(
                              "PT.TINOJER ACADEMY",
                              style: FontFamily().regularText.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorStyle().disableColors,
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "*Pembayaran berlaku sampai 24 jam setelah melakukan booking kelas",
                  style: FontFamily()
                      .regularText
                      .copyWith(color: ColorStyle().errorColors),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: ElevatedButtonWidget(
                  title: "Kembali Ke Beranda",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavbarMenteeScreen(
                                activeScreen: 0,
                              )),
                      (Route<dynamic> route) =>
                          false, // Remove all routes until the new route
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          )
        ],
      ),
    );
  }
}
