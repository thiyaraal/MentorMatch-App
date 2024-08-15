import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class CarouselCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  CarouselCard({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: ColorStyle().tertiaryColors,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorStyle().secondaryColors,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description,
                      style: FontFamily().regularText.copyWith(
                            fontSize: 10,
                          ) // Ganti dengan FontFamily().regularText jika ada
                      ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: 132,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(imagePath).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
