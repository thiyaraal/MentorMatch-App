import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class PaymentPopupMenu extends StatelessWidget {
  const PaymentPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 155.0,
            right: 155.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Payment Booking",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: Color(0xffE78938),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 807,
                    height: 185,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F0F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "IDR 1.000.000,00",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 42,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama Kelas",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Nama Mentor",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Periode Kelas",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 35),
                          Text(
                            "Metode Pembayaran",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "No Rekening",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 28,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\n: UI/UX Research & Design",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            ": Steven Jobs",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            ": 3 Bulan",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 35),
                          Text(
                            ": Transfer Bank",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ": 000000000012345678\n PT.TINOJER Academy",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: Colors.orange,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: "000000000012345678",
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("Rekening copied to clipboard"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffE78938), // Background color
                        padding: EdgeInsets.symmetric(
                          vertical: 35.0,
                          horizontal: 135.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        "Selesai",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
