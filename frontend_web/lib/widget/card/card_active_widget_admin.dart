import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

class CardActiveAdminWidget extends StatefulWidget {
  final String text;
  final ImageProvider image;
  final VoidCallback onTap;
  final bool isActive;

  CardActiveAdminWidget({
    Key? key,
    required this.text,
    required this.image,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  State<CardActiveAdminWidget> createState() => _CardActiveAdminWidgetState();
}

class _CardActiveAdminWidgetState extends State<CardActiveAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.isActive
                ? ColorStyle().primaryColors
                : ColorStyle().primaryColors.withOpacity(0.5),
          ),
          width: 293,
          height: 150,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: widget.image,
                width: 100,
                height: 80,
              ),
              Text(
                widget.text,
                style: TextStyle(fontSize: 16, color: ColorStyle().whiteColors),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
