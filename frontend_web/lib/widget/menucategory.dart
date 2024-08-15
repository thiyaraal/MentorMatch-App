import 'package:flutter/material.dart';
import 'package:my_flutter_app/style/fontStyle.dart';

class ColorStyle {
  Color primaryColors = const Color(0xffE37517); // He
  Color secondaryColors = const Color(0xff0A1737);
  Color tertiaryColors = const Color(0xffF8F1F1);
  Color textColors = const Color(0xff313030);
  Color blackColors = const Color(0xff000000);
  Color whiteColors = const Color(0xffFFFFFF);
  Color disableColors = const Color(0xff949090);
  Color errorColors = const Color(0xffC51818);
  Color succesColors = const Color(0xff27D024);
  Color pendingColors = const Color(0xffF1DA0D);
  Color fullbookedColors = const Color(0xff5D5FEF);
}

class CustomCategoryWidget extends StatelessWidget {
  final String text;
  final String img;
  final VoidCallback? onTap;

  CustomCategoryWidget({required this.text, required this.img, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(img),
          ),
          const SizedBox(height: 4),
          Text(text, style: FontFamily().regularText),
        ],
      ),
    );
  }
}
