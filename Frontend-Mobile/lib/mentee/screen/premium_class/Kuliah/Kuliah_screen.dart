import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/all_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/computer_science_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/design_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/electro_kulaih_screem.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/ilkom_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/information_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/manajemen_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/psikolog_kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/teacher_kuliah_screen.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/category_card.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class KuliahScreen extends StatefulWidget {
  KuliahScreen({Key? key}) : super(key: key);

  @override
  State<KuliahScreen> createState() => _KuliahScreenState();
}

class _KuliahScreenState extends State<KuliahScreen> {
  bool isAllCategoryActive = true;
  bool isBahasaActive = false;
  bool isIlkomActive = false;
  bool isComputerScienceActive = false;
  bool isPsikologiActive = false;
  bool isManajemenActive = false;
  bool isPendidikanGuruActive = false;
  bool isInformationActive = false;
  bool isElektroActive = false;
  bool isDesignActive = false;

  void _handleMenuSelected(String menu) {
    setState(
      () {
        if (menu == 'All') {
          isAllCategoryActive = true;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Design') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = true;
        } else if (menu == 'Ilmu Komunikasi') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = true;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Computer Science') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = true;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Psikologi') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = true;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Manajemen') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = true;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Pendidikan Guru') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = true;
          isInformationActive = false;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Information') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = true;
          isElektroActive = false;
          isDesignActive = false;
        } else if (menu == 'Elektro') {
          isAllCategoryActive = false;
          isBahasaActive = false;
          isIlkomActive = false;
          isComputerScienceActive = false;
          isPsikologiActive = false;
          isManajemenActive = false;
          isPendidikanGuruActive = false;
          isInformationActive = false;
          isElektroActive = true;
          isDesignActive = false;
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
            'Kuliah',
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
                        img: 'assets/Handoff/icon/categoryIcon/Kuliah/all.png',
                      ),
                      CategoriCardWidget(
                        isActive: isPsikologiActive,
                        onTap: () {
                          _handleMenuSelected('Psikologi');
                        },
                        title: "Psikologi",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/psikolog.png',
                      ),
                      CategoriCardWidget(
                        isActive: isDesignActive,
                        onTap: () {
                          _handleMenuSelected('Design');
                        },
                        title: "Design",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/design.png',
                      ),
                      CategoriCardWidget(
                        isActive: isElektroActive,
                        onTap: () {
                          _handleMenuSelected('Elektro');
                        },
                        title: "Elecktro",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/electro.png',
                      ),
                      CategoriCardWidget(
                        isActive: isManajemenActive,
                        onTap: () {
                          _handleMenuSelected('Manajemen');
                        },
                        title: "Manajemen",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/manajemen.png',
                      ),
                      CategoriCardWidget(
                        isActive: isInformationActive,
                        onTap: () {
                          _handleMenuSelected('Information');
                        },
                        title: "Information",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/Information.png',
                      ),
                      CategoriCardWidget(
                        isActive: isComputerScienceActive,
                        onTap: () {
                          _handleMenuSelected('Computer Science');
                        },
                        title: "Computer Science",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/Computer Scince.png',
                      ),
                      CategoriCardWidget(
                        isActive: isIlkomActive,
                        onTap: () {
                          _handleMenuSelected('Ilmu Komunikasi');
                        },
                        title: "Ilmu Komunikasi",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/ilkon.png',
                      ),
                      CategoriCardWidget(
                        isActive: isPendidikanGuruActive,
                        onTap: () {
                          _handleMenuSelected('Pendidikan Guru');
                        },
                        title: "Pendidikan Guru",
                        img:
                            'assets/Handoff/icon/categoryIcon/Kuliah/teacher.png',
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isAllCategoryActive
                        ? AllKuliahScreen()
                        : isIlkomActive
                            ? IlkomKuliahScreen()
                            : isComputerScienceActive
                                ? ComputerScinceKuliahScreen()
                                : isDesignActive
                                    ? DesignKuliahScreen()
                                    : isElektroActive
                                        ? ElectroKuliahScreen()
                                        : isInformationActive
                                            ? InformationKuliahScreen()
                                            : isManajemenActive
                                                ? ManajemenKuliahScreen()
                                                : isPendidikanGuruActive
                                                    ? TeacherKuliahScreen()
                                                    : isPsikologiActive
                                                        ? PsikologKuliahScreen()
                                                        : AllKuliahScreen()
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
