import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/all_sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/bahasa_sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/math_sd_scree.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/sains_sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/tech_sd_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class SDScreen extends StatefulWidget {
  SDScreen({Key? key}) : super(key: key);

  @override
  State<SDScreen> createState() => _SDScreenState();
}

class _SDScreenState extends State<SDScreen> {
  bool isAllCategoryActive = true;
  bool isBahasaActive = false;
  bool isSainsActive = false;
  bool isTechActive = false;
  bool isMathActive = false;

  void _handleMenuSelected(String menu) {
    setState(
      () {
        if (menu == 'All') {
          isAllCategoryActive = true;
          isBahasaActive = false;
          isSainsActive = false;
          isTechActive = false;
          isMathActive = false;
        } else if (menu == 'Bahasa') {
          isAllCategoryActive = false;
          isBahasaActive = true;
          isSainsActive = false;
          isTechActive = false;
          isMathActive = false;
        } else if (menu == 'Sains') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isSainsActive = true;
          isTechActive = false;
          isMathActive = false;
        } else if (menu == 'Teknologi') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isSainsActive = false;
          isTechActive = true;
          isMathActive = false;
        } else if (menu == 'Matematika') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isSainsActive = false;
          isTechActive = false;
          isMathActive = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'SD',
            style: FontFamily().boldText.copyWith(
                  color: ColorStyle().primaryColors,
                  fontSize: 16.0,
                ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidgetMentee(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoriCardWidget(
                        isActive: isAllCategoryActive,
                        onTap: () {
                          _handleMenuSelected('All');
                        },
                        title: "All",
                        img: 'assets/Handoff/icon/categoryIcon/SD/all.png',
                      ),
                      CategoriCardWidget(
                        isActive: isMathActive,
                        onTap: () {
                          _handleMenuSelected('Matematika');
                        },
                        title: "Matematika",
                        img: 'assets/Handoff/icon/categoryIcon/SD/math.png',
                      ),
                      CategoriCardWidget(
                        isActive: isSainsActive,
                        onTap: () {
                          _handleMenuSelected('Sains');
                        },
                        title: "Sains",
                        img:
                            'assets/Handoff/icon/categoryIcon/SD/Pengetahuan.jpg',
                      ),
                      CategoriCardWidget(
                        isActive: isBahasaActive,
                        onTap: () {
                          _handleMenuSelected('Bahasa');
                        },
                        title: "Bahasa",
                        img:
                            'assets/Handoff/icon/categoryIcon/SD/Sastra Bahasa.png',
                      ),
                      CategoriCardWidget(
                        isActive: isTechActive,
                        onTap: () {
                          _handleMenuSelected('Teknologi');
                        },
                        title: "Teknologi",
                        img: 'assets/Handoff/icon/categoryIcon/SD/tech.png',
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isAllCategoryActive
                        ? AllSDScreen()
                        : isBahasaActive
                            ? BahasaSDScreen()
                            : isSainsActive
                                ? SainsSDScreen()
                                : isTechActive
                                    ? TechSDScreen()
                                    : isMathActive
                                        ? MathSDScreen()
                                        : AllSDScreen()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
