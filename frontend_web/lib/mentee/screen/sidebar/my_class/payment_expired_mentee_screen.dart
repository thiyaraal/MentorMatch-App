import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentExpiredScreenMentee extends StatefulWidget {
  PaymentExpiredScreenMentee({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentExpiredScreenMentee> createState() =>
      _PaymentExpiredScreenMenteeState();
}

class _PaymentExpiredScreenMenteeState
    extends State<PaymentExpiredScreenMentee> {
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
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return '${formatter.format(amount)},00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: AppBar(
        backgroundColor: ColorStyle().whiteColors,
      ),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 800,
          child: ListView(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        left: 24.0,
                        right: 8.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        "Transaksi Expired",
                        style: FontFamily().boldText.copyWith(
                              fontSize: 26,
                              color: ColorStyle().errorColors,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Mohon maaf, transaksi pembayaran untuk kelas ini telah expired. Silakan lakukan pembookingan ulang kelas.",
                        style: FontFamily().regularText.copyWith(
                            color: ColorStyle().disableColors, fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 500,
                    height: 500,
                    child: Image.asset(
                      'assets/Handoff/ilustrator/payment-gagal.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
