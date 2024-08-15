import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class ReviewWidget extends StatelessWidget {
  final String name;
  final String review;
  const ReviewWidget({Key? key, required this.name, required this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                          color: ColorStyle().tertiaryColors,
                          borderRadius: BorderRadius.circular(8),
                        ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.emoji_emotions_outlined,
                    size: 40, color: ColorStyle().secondaryColors),
                SizedBox(
                  width: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    name,
                    style: FontFamily().titleText.copyWith(
                        color: ColorStyle().secondaryColors, fontSize: 12),
                  ),
                ),
              ],
            ),
            Text(
              review,
              style: FontFamily().regularText,
            )
          ],
        ),
      ),
    );
  }
}
