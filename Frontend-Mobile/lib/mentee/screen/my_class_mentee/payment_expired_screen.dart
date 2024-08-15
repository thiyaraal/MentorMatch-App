import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

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
  @override
  Widget build(BuildContext context) {
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
                                  "Transaksi Expired",
                                  style: FontFamily().boldText.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: ColorStyle().errorColors),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Mohon maaf, transaksi pembayaran untuk kelas ini telah expired. Silakan lakukan pembookingan ulang kelas.",
                                  style: FontFamily().regularText.copyWith(
                                        color: ColorStyle().disableColors,
                                        fontSize: 14,
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
