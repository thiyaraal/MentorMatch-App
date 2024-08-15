import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/flush_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPendingScreenMentee extends StatefulWidget {
  final String classname;
  final int price;
  final String rejectReason;
  final int uniqueId;
  PaymentPendingScreenMentee(
      {Key? key,
      required this.classname,
      required this.price,
      required this.uniqueId,
      required this.rejectReason})
      : super(key: key);

  @override
  State<PaymentPendingScreenMentee> createState() =>
      _PaymentPendingScreenMenteeState();
}

class _PaymentPendingScreenMenteeState
    extends State<PaymentPendingScreenMentee> {
  final String phoneNumber =
      "+6281362845327"; // Ganti dengan nomor telepon tujuan

  Future<void> _launchWhatsApp() async {
    final String url = "https://wa.me/$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.price + widget.uniqueId;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    "assets/Handoff/ilustrator/payment-gagal.png",
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ColorStyle().whiteColors,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
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
                                Text(
                                  "Menunggu Pembayaran",
                                  style: FontFamily().boldText.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: ColorStyle().pendingColors),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Segera lakukan pembayaran untuk mengikuti kelas",
                                  style: FontFamily().regularText.copyWith(
                                        color: ColorStyle().disableColors,
                                        fontSize: 14,
                                      ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Nama Kelas",
                                  style: FontFamily().boldText.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: ColorStyle().primaryColors,
                                      ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.classname,
                                  style: FontFamily().regularText.copyWith(
                                        color: ColorStyle().disableColors,
                                        fontSize: 14,
                                      ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text("Nominal Pembayaran",
                                    style: FontFamily().boldText.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: ColorStyle().primaryColors,
                                        )),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  formatCurrency(totalAmount),
                                  style: FontFamily().regularText.copyWith(
                                        color: ColorStyle().disableColors,
                                        fontSize: 14,
                                      ),
                                ),
                                SizedBox(
                                  height: 12,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "*Pembayaran berlaku sampai 24 jam setelah melakukan booking kelas",
                                  style: FontFamily().regularText.copyWith(
                                      color: ColorStyle().errorColors),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
