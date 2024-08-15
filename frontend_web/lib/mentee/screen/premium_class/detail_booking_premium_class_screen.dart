import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/Mentee/screen/homepage_mentee.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/detail_class_mentor_sd_screen.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/button.dart';
import 'package:my_flutter_app/widget/flushsBar_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

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

String formatCurrency(int amount) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
  return '${formatter.format(amount)},00';
}

class _DetailBookingClassState extends State<DetailBookingClass> {
  @override
  Widget build(BuildContext context) {
    int totalAmount = widget.price + widget.uniqueCode;
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: AppBar(),
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
                      ),
                      child: Text(
                        "Payment Class",
                        style: FontFamily().boldText.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: ColorStyle().secondaryColors),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      "Terima kasih telah melakukan booking kelas dengan kami. Pesanan Anda telah diterima dengan baik. Namun, untuk mengonfirmasi keikutsertaan Anda, pembayaran harus dilakukan.",
                      style: FontFamily().regularText.copyWith(
                          color: ColorStyle().disableColors, fontSize: 14),
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
                            width: 42.12,
                            child: Image.asset(
                              'assets/Handoff/payment.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Total Pembayaran",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(fontSize: 14),
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
                                                          .secondaryColors,
                                                      fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                            message: widget
                                                .nama_kelas, // Isi tooltip dengan nama_kelas lengkap
                                            child: Text(
                                                widget.nama_kelas.length > 20
                                                    ? '${widget.nama_kelas.substring(0, 20)}...'
                                                    : widget.nama_kelas,
                                                style: FontFamily()
                                                    .regularText
                                                    .copyWith(
                                                        color: ColorStyle()
                                                            .disableColors))),
                                      ],
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
                                        Text(widget.nama_mentor,
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, top: 8.0),
                                          child: Text(
                                            "Periode Kelas",
                                            style: FontFamily()
                                                .boldText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .primaryColors,
                                                    fontSize: 14),
                                          ),
                                        ),
                                        Text('${widget.durasi} Hari',
                                            style: FontFamily()
                                                .regularText
                                                .copyWith(
                                                    color: ColorStyle()
                                                        .disableColors)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, top: 8.0),
                                      child: Text(
                                        "Metode Pembayaran :",
                                        style: FontFamily().boldText.copyWith(
                                            color: ColorStyle().primaryColors,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      "BANK BCA",
                                      style: FontFamily().boldText.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "PT.TINOJER ACADEMY",
                                          style: FontFamily()
                                              .regularText
                                              .copyWith(
                                                  color: ColorStyle()
                                                      .disableColors),
                                        ),
                                        Text(
                                          '1234567890',
                                          style: FontFamily().boldText.copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Menyalin teks ke clipboard
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text: '1234567890'));

                                            // Tampilkan snackbar atau pesan bahwa teks telah disalin
                                            showTopSnackBar(
                                                context, 'Teks telah disalin');
                                          },
                                          icon: const Icon(Icons.copy),
                                        )
                                      ],
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
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButtonWidget2(
                                  title: "Kembali Ke Beranda",
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MenteeHomePage(),
                                      ),
                                    );
                                  },
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
