import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewMenteeDialog extends StatelessWidget {
  const ReviewMenteeDialog({Key? key}) : super(key: key);

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
                "Nonaktifkan Kelas",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: Color(0xffE78938),
                ),
              ),
              Image.asset(
                'assets/Handoff/ilustrator/question.png', // Replace with your image path
                height: 500,
                width: 500,
                fit: BoxFit.contain,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Text(
                      "Kamu dapat menyelesaiakan program ini apabila periode premium class yang kamu ikuti telah selesai dilakukan sesuai dengan jadwal yang tersedia. Apabila kamu menonaktifkan kelas ini maka kamu dan mentee tidak dapat melanjutkan kelas ini.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 24,
                        color: Color(0xff313030),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          "Non Aktif",
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
