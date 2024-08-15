import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewWidget extends StatelessWidget {
  final String name;
  final String review;

  const ReviewWidget({Key? key, required this.name, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color:
                      const Color(0xff0A1737), // Use secondaryColors directly
                ),
              ),
            ],
          ),
          Text(
            review,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: const Color(0xff313030), // Use textColors directly
            ),
          )
        ],
      ),
    );
  }
}
