import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/all_sd_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/bahasa_sd_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/math_sd_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/sains_sd_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/tech_sd_screen.dart';
import 'package:my_flutter_app/widget/category_card.dart';
import 'package:my_flutter_app/widget/footer.dart';
import 'package:my_flutter_app/widget/navbaruser.dart';
import 'package:my_flutter_app/widget/searchbar.dart';

class SDScreen extends StatefulWidget {
  const SDScreen({Key? key}) : super(key: key);

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NavbarWidgetSD(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SearchBarWidget(
                  title: 'Search by name, role, company',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 20,
                ),
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
                            'assets/Handoff/icon/categoryIcon/SD/Sastra_Bahasa.png',
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
                SizedBox(
                  height: 20,
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
          FooterWidget(), //
        ],
      ),
    );
  }

  List<String> categoryList = [
    "All Mentor",
    "Matematika",
    "Pengetahuan",
    "Bahasa",
    "Teknologi",
  ];
}
