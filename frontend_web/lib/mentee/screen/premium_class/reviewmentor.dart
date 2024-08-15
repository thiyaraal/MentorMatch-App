import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewMentorDialog extends StatelessWidget {
  const ReviewMentorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 55.0,
            horizontal: 55.0,
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
                "Review Mentor",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: Color(0xffE78938),
                ),
              ),
              Image.asset(
                'assets/Handoff/ilustrator/review.png', // Replace with your image path
                height: 500,
                width: 500,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 24,
                        color: Color(0xff313030),
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Halo Charline, pastikan memberikan review setelah menyelesaikan program ini. Ingat, \n",
                        ),
                        TextSpan(
                          text: "satu review saja di akhir program",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              ". Gunakan kata-kata dengan bijak dalam\n memberikan ulasan. Nama dan ulasanmu akan terlihat di profil mentor. Terima kasih!",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 155.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w100,
                      ),
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Tuliskan Review kepada Mentor",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Color(0xffE78938),
                          ), // Border color
                          padding: EdgeInsets.symmetric(
                            vertical: 35.0,
                            horizontal: 135.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          "Batal",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 32,
                            color: Color(0xffE78938),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Kirim button functionality
                          // Add your logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xffE78938), // Background color
                          padding: EdgeInsets.symmetric(
                            vertical: 35.0,
                            horizontal: 135.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          "Kirim",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
