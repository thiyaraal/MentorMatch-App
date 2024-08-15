import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MentorConfirmationPage extends StatefulWidget {
  const MentorConfirmationPage({Key? key}) : super(key: key);

  @override
  _MentorConfirmationPageState createState() => _MentorConfirmationPageState();
}

class _MentorConfirmationPageState extends State<MentorConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Row(
            children: [
              const SizedBox(width: 20),
              Image.asset(
                'assets/Handoff/logo/LogoWeb.png',
                height: 150,
                width: 150,
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        // Enables scrolling when necessary
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 1000), // Set a max width for web-like centering
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Handoff/ilustrator/verification.png',
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                    height: 20), // Add space between the image and the text
                Text.rich(
                  TextSpan(
                    text: 'Terima kasih telah mendaftar \nsebagai mentor di ',
                    style: GoogleFonts.poppins(fontSize: 32),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'MentorMatch.',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'Proses verifikasi memerlukan waktu paling lama ',
                    style: GoogleFonts.poppins(fontSize: 24),
                    children: <TextSpan>[
                      TextSpan(
                        text: '3 hari ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      TextSpan(
                        text:
                            'untuk memastikan bahwa \nsetiap mentor memenuhi standar kualitas yang telah ditetapkan. Anda dapat \nmengakses aplikasi setelah pesan verifikasi masuk kedalam email anda. \nKami sangat menghargai kesabaran Anda selama proses ini.',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
