import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/font_style.dart';

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
            height: 23,
            width: 23,
            child: Image.asset(img),
          ),
          const SizedBox(height: 4),
          Text(text, style: FontFamily().regularText,),
        ],
      ),
    );
  }
}
