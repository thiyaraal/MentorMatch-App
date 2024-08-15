import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPendingScreenMentee extends StatefulWidget {
  final String classname;
  final String mentorname;
  final int price;

  final String rejectReason;
  final int uniqueId;
  PaymentPendingScreenMentee(
      {Key? key,
      required this.mentorname,
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
    final formatter = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return '${formatter.format(amount)},00';
  }

  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.price + widget.uniqueId;
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
                        'Menunggu Pembayaran',
                        style: FontFamily().boldText.copyWith(
                              fontSize: 26,
                              color: ColorStyle().pendingColors,
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
                        "Segera lakukan pembayaran untuk mengikuti kelas",
                        style: FontFamily().regularText.copyWith(
                            color: ColorStyle().disableColors, fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SizedBox(
                            width: 620,
                            height: 400,
                            child: Image.asset(
                              'assets/Handoff/ilustrator/payment-gagal.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorStyle().whiteColors,
                            borderRadius: BorderRadius.circular(8),
                            // add border color
                            border: Border.all(
                              color: ColorStyle().tertiaryColors,
                              width: 4,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 12,
                                    bottom: 12.0,
                                    right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Detail Transaction",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              formatCurrency(totalAmount),
                                              style: FontFamily()
                                                  .boldText
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorStyle()
                                                          .disableColors,
                                                      fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, top: 8.0),
                                          child: Text(
                                            "Nama Kelas",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .primaryColors,
                                                    fontSize: 14),
                                          ),
                                        ),
                                        Tooltip(
                                          message: widget.classname,
                                          child: Text(
                                            widget.classname,
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, top: 8.0),
                                          child: Text(
                                            "Nama Mentor",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .primaryColors,
                                                    fontSize: 14),
                                          ),
                                        ),
                                        Text(widget.mentorname,
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Metode Pembayaran",
                                      style: FontFamily().boldText.copyWith(
                                          color: ColorStyle().primaryColors,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Bank BCA",
                                      style: FontFamily().boldText.copyWith(
                                          color: ColorStyle().primaryColors,
                                          fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '00000001234567890',
                                          style: FontFamily()
                                              .regularText
                                              .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    ColorStyle().disableColors,
                                                fontSize: 12,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Menyalin teks ke clipboard
                                            Clipboard.setData(
                                                const ClipboardData(
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
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "*Pembayaran berlaku sampai 24 jam setelah melakukan booking kelas",
                                  style: FontFamily().regularText.copyWith(
                                      fontSize: 12,
                                      color: ColorStyle().errorColors),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
