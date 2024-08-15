import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/all_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/bahasa_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/biologi_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/ekonomi_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/fisika_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/geografi_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/kimia_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/matematika_smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/teknologi_smp_screen.dart';
import 'package:my_flutter_app/widget/category_card.dart';
import 'package:my_flutter_app/widget/navbaruser.dart';
import 'package:my_flutter_app/widget/searchbar.dart';

class SMPScreen extends StatefulWidget {
  SMPScreen({Key? key}) : super(key: key);

  @override
  State<SMPScreen> createState() => _SMPScreenState();
}

class _SMPScreenState extends State<SMPScreen> {
  bool isAllCategoryActive = true;
  bool isBiologyActive = false;
  bool isEkonomiActive = false;
  bool isTechActive = false;
  bool isMathActive = false;
  bool isKimiaActive = false;
  bool isGeografiActive = false;
  bool isFisikaActive = false;
  bool isBahasaActive = false;

  void _handleMenuSelected(String menu) {
    setState(
      () {
        if (menu == 'All') {
          isAllCategoryActive = true;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Biology') {
          isAllCategoryActive = false;
          isBiologyActive = true;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Ekonomi') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = true;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Fisika') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = true;
          isBahasaActive = false;
        } else if (menu == 'Geografi') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = true;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Kimia') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = true;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Bahasa') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = true;
        } else if (menu == 'Matematika') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = false;
          isMathActive = true;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        } else if (menu == 'Teknologi') {
          isAllCategoryActive = false;
          isBiologyActive = false;
          isEkonomiActive = false;
          isTechActive = true;
          isMathActive = false;
          isKimiaActive = false;
          isGeografiActive = false;
          isFisikaActive = false;
          isBahasaActive = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NavbarWidgetSMP(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        img: 'assets/Handoff/icon/categoryIcon/SMP/all.png',
                      ),
                      CategoriCardWidget(
                        isActive: isGeografiActive,
                        onTap: () {
                          _handleMenuSelected('Geografi');
                        },
                        title: "Geografi",
                        img:
                            'assets/Handoff/icon/categoryIcon/SMP/geografi.png',
                      ),
                      CategoriCardWidget(
                        isActive: isEkonomiActive,
                        onTap: () {
                          _handleMenuSelected('Ekonomi');
                        },
                        title: "Ekonomi",
                        img: 'assets/Handoff/icon/categoryIcon/SMP/economi.png',
                      ),
                      CategoriCardWidget(
                        isActive: isBiologyActive,
                        onTap: () {
                          _handleMenuSelected('Biology');
                        },
                        title: "Biology",
                        img: 'assets/Handoff/icon/categoryIcon/SMP/bilogy.png',
                      ),
                      CategoriCardWidget(
                        isActive: isFisikaActive,
                        onTap: () {
                          _handleMenuSelected('Fisika');
                        },
                        title: "Fisika",
                        img: 'assets/Handoff/icon/categoryIcon/SMP/fisika.png',
                      ),
                      CategoriCardWidget(
                        isActive: isBahasaActive,
                        onTap: () {
                          _handleMenuSelected('Bahasa');
                        },
                        title: "Bahasa",
                        img:
                            'assets/Handoff/icon/categoryIcon/SMP/Sastra_Bahasa.png',
                      ),
                      CategoriCardWidget(
                        isActive: isKimiaActive,
                        onTap: () {
                          _handleMenuSelected('Kimia');
                        },
                        title: "Kimia",
                        img: 'assets/Handoff/icon/categoryIcon/SMP/kimia.png',
                      ),
                      CategoriCardWidget(
                        isActive: isTechActive,
                        onTap: () {
                          _handleMenuSelected('Teknologi');
                        },
                        title: "Teknologi",
                        img: 'assets/Handoff/icon/categoryIcon/SMP/tech.png',
                      ),
                      CategoriCardWidget(
                        isActive: isMathActive,
                        onTap: () {
                          _handleMenuSelected('Matematika');
                        },
                        title: "Matematika",
                        img: 'assets/Handoff/icon/categoryIcon/SMP/math.png',
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
                        ? AllSMPScreen()
                        : isBiologyActive
                            ? BiologiSMPScreen()
                            : isEkonomiActive
                                ? EkonomiSMPScreen()
                                : isTechActive
                                    ? TeknologiSMPScreen()
                                    : isMathActive
                                        ? MatematikaSMPScreen()
                                        : isBahasaActive
                                            ? BahasaSMPScreen()
                                            : isKimiaActive
                                                ? KimiaSMPScreen()
                                                : isGeografiActive
                                                    ? GeografiSMPScreen()
                                                    : isFisikaActive
                                                        ? FisikaSMPScreen()
                                                        : AllSMPScreen()
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

class TechSMPScreen {}
