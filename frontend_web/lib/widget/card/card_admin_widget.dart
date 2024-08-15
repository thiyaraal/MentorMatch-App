import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';

class CardDasboardRightAdmin extends StatefulWidget {
  final String text1;
  final String text2;
  final ImageProvider image;
  CardDasboardRightAdmin({
    Key? key,
    required this.text1,
    required this.image,
    required this.text2,
  }) : super(key: key);

  @override
  State<CardDasboardRightAdmin> createState() => _CardDasboardRightAdminState();
}

class _CardDasboardRightAdminState extends State<CardDasboardRightAdmin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle().secondaryColors,
        ),
        width: 220,
        height: 160,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: widget.image,
              width: 80,
              height: 60,
            ),
            Text(
              widget.text1,
              style: FontFamily().titleText.copyWith(
                    fontSize: 16,
                    color: ColorStyle().whiteColors,
                  ),
            ),
            Text(
              widget.text2,
              style: FontFamily().regularText.copyWith(
                    fontSize: 16,
                    color: ColorStyle().whiteColors,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
