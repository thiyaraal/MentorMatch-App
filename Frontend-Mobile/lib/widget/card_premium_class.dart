import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/style/text.dart';
import 'package:mentormatch_apps/widget/button.dart';

class CardPremiumClassOptions extends StatefulWidget {
  final String image;

  final String? description;
  final VoidCallback? onPressed;
  const CardPremiumClassOptions(
      {Key? key, this.description, this.onPressed, required this.image})
      : super(key: key);

  @override
  State<CardPremiumClassOptions> createState() =>
      _CardPremiumClassOptionsState();
}

class _CardPremiumClassOptionsState extends State<CardPremiumClassOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: ColorStyle().tertiaryColors,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 130,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(widget.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.description!, style: FontFamily().regularText),
                    const SizedBox(height: 12),
                    SmallElevatedButton(
                      width: 120,
                      height: 36,
                      onPressed: widget.onPressed,
                      title: 'Lihat Kelas',
                      color: ColorStyle().primaryColors,
                      style: FontFamily().buttonText.copyWith(
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContohPremiumClass extends StatefulWidget {
  final String tittle;
  final String desc;
  CardContohPremiumClass({Key? key, required this.tittle, required this.desc})
      : super(key: key);

  @override
  State<CardContohPremiumClass> createState() => _CardContohPremiumClassState();
}

class _CardContohPremiumClassState extends State<CardContohPremiumClass> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: ColorStyle().tertiaryColors),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TittleTextField(
                title: widget.tittle,
              ),
              Text(
                widget.desc,
                style: FontFamily().regularText,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardContohPremiumClassDropDown extends StatefulWidget {
  final String title;
  final String desc;
  final String subtitle;
  final Widget widget;
  final bool dropdownContent;
  final bool isDropdownOpened;
  final Function toggleDropdown;
  CardContohPremiumClassDropDown(
      {Key? key,
      required this.title,
      required this.dropdownContent,
      required this.isDropdownOpened,
      required this.toggleDropdown,
      required this.desc,
      required this.subtitle,
      required this.widget})
      : super(key: key);

  @override
  State<CardContohPremiumClassDropDown> createState() =>
      _CardContohPremiumClassDropDownState();
}

class _CardContohPremiumClassDropDownState
    extends State<CardContohPremiumClassDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: ColorStyle().tertiaryColors),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TittleTextField(
                title: widget.title,
              ),
              Text(
                widget.desc,
                style: FontFamily().regularText.copyWith(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    widget.subtitle,
                    style: FontFamily().regularText.copyWith(
                        color: ColorStyle().primaryColors,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.toggleDropdown();
                    },
                    icon: Icon(widget.isDropdownOpened
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down_outlined),
                  ),
                ],
              ),
              if (widget.isDropdownOpened)
                Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: widget.widget),
            ],
          ),
        ),
      ),
    );
  }
}
