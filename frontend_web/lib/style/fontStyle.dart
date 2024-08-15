import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class FontFamily {
  TextStyle titleText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: ColorStyle().secondaryColors,
  );
  TextStyle buttonText = GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: ColorStyle().whiteColors,
  );
  TextStyle regularText = GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: ColorStyle().textColors,
  );
  TextStyle boldText = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: ColorStyle().textColors,
  );
  TextStyle titleTextField = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: ColorStyle().secondaryColors,
  );
}
