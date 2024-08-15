import 'package:flutter/material.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
class CategoriCardWidget extends StatefulWidget {
  final bool isActive;
  final String img;
  final String title;
  final VoidCallback? onTap;
  CategoriCardWidget(
      {Key? key,
      required this.img,
      required this.title,
      this.onTap,
      required this.isActive})
      : super(key: key);

  @override
  State<CategoriCardWidget> createState() => _CategoriCardWidgetState();
}

class _CategoriCardWidgetState extends State<CategoriCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.00),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.img, height: 40, width: 40),
            const SizedBox(height: 8), // Add space between image and text
            Text(
              widget.title,
              style: FontFamily().boldText.copyWith(
                    fontSize: 12,
                    color: widget.isActive
                        ? ColorStyle().primaryColors
                        : ColorStyle().disableColors,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String skill;
  SkillCard({Key? key, required this.skill}) : super(key: key);

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: ColorStyle().secondaryColors,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.skill, style: FontFamily().regularText),
          ),
        ),
      ),
    );
  }
}

class CardMyClass extends StatefulWidget {
  final String messsage;
  final String title;
  final String icon;
  final VoidCallback? onTap;
  CardMyClass(
      {Key? key,
      required this.title,
      required this.icon,
      this.onTap,
      required this.messsage})
      : super(key: key);

  @override
  State<CardMyClass> createState() => _CardMyClassState();
}

class _CardMyClassState extends State<CardMyClass> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.messsage,
      child: Container(
        width: 89,
        height: 89,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorStyle().disableColors,
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: ColorStyle().primaryColors,
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.icon,
              ),
              // Add space between image and text
              const SizedBox(height: 4),
              Text(
                widget.title,
                style: FontFamily().boldText.copyWith(
                      fontSize: 12,
                      color: ColorStyle().whiteColors,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterestCardMentor extends StatefulWidget {
  final String title;
  final String icon;
  InterestCardMentor({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  State<InterestCardMentor> createState() => _InterestCardMentorState();
}

class _InterestCardMentorState extends State<InterestCardMentor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.icon, width: 60),
            // Add space between image and text
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: FontFamily().regularText.copyWith(
                    fontSize: 12,
                    color: ColorStyle().secondaryColors,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
