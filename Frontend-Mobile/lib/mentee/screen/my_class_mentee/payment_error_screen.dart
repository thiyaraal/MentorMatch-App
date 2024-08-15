import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentErrorScreenMentee extends StatefulWidget {
  final String classname;
  final int price;
  // final String paymentdate;
  final String rejectReason;
  final int uniqueId;
  PaymentErrorScreenMentee(
      {Key? key,
      required this.classname,
      required this.price,
      // required this.paymentdate,
      required this.uniqueId,
      required this.rejectReason})
      : super(key: key);

  @override
  State<PaymentErrorScreenMentee> createState() =>
      _PaymentErrorScreenMenteeState();
}

class _PaymentErrorScreenMenteeState extends State<PaymentErrorScreenMentee> {
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
    final formatter = NumberFormat.currency(
        locale: 'id', symbol: 'Rp');
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
                                  "Transaksi Gagal",
                                  style: FontFamily().boldText.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: ColorStyle().errorColors),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Mohon maaf, transaksi yang kamu lakukan untuk membooking kelas ini gagal dikarenakan: ${widget.rejectReason}",
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
                                  height: 24,
                                ),
                                Text(
                                    "Silahkan hubungi kontak admin dibawah ini untuk proses lebih lanjut",
                                    style: FontFamily().regularText.copyWith(
                                          color: ColorStyle().disableColors,
                                          fontSize: 14,
                                        )),
                                SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 48,
                                        width: 132,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: ColorStyle().succesColors,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextButton.icon(
                                          onPressed: _launchWhatsApp,
                                          label: Text(
                                            'WhatsApp ',
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                  color:
                                                      ColorStyle().whiteColors,
                                                ),
                                          ),
                                          icon: Icon(
                                            Icons.phone,
                                            color: ColorStyle().whiteColors,
                                          ),
                                          style: ButtonStyle(
                                            iconSize:
                                                WidgetStateProperty.all(20),
                                            padding: WidgetStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
