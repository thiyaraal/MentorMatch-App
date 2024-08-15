import 'package:flutter/material.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import '../menucategory.dart';

class CategoryCardPremiumClass extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const CategoryCardPremiumClass(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  State<CategoryCardPremiumClass> createState() =>
      _CategoryCardPremiumClassState();
}

class _CategoryCardPremiumClassState extends State<CategoryCardPremiumClass> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: 900,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorStyle().whiteColors, backgroundColor: ColorStyle().tertiaryColors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: FontFamily().regularText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle().secondaryColors),
            ),
          ),
        ),
      ),
    );
  }
}
