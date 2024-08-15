import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/widget/footer.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/navbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: NavbarWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 150, vertical: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang di Aplikasi MentorMatch',
                          style: GoogleFonts.poppins(
                              fontSize: 40, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Mari lanjutkan langkah untuk dunia pendidikan yang lebih baik. Ikuti sesi mentoring bersama para mentor ahli yang siap membantu kamu mencapai target dan tujuanmu.',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: ColorStyle().disableColors,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 80),
                  Expanded(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: SizedBox(
                        width: 202.12,
                        child: Image.asset(
                          'assets/Handoff/ilustrator/first_screen.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 150, vertical: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Class Program',
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: ColorStyle().textColors),
                  ),
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Card(
                          color: const Color(0xFFF9F1F0),
                          child: Container(
                            height: 400,
                            width: 300,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/Handoff/ilustrator/Premiumclassverified.png',
                                  fit: BoxFit.fill,
                                ),
                                ListTile(
                                  title: Text(
                                    'Mentor Terpercaya & Terverifikasi baik',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    'Menyediakan mentor yang berpengalaman dan terverifikasi mampu memberikan bimbingan yang baik dibidang nya',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Session Gratis',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: SizedBox(
                            width: 902.12,
                            child: Image.asset(
                              'assets/Handoff/ilustrator/Sessiongratisteacher.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 45),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Nikmati Session Gratis dengan\npara mentor berpengalaman',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              'Bergabunglah dalam sesi gratis di MentorMatch dan rasakan pengalaman pembelajaran yang akan membawa Anda keluar dari zona nyaman. Sesi ini dirancang untuk memberi Anda gambaran nyata tentang potensi dan keuntungan belajar bersama mentor ahli.',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: ColorStyle().disableColors),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}
