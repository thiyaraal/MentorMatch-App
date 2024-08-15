import 'package:flutter/material.dart';
import 'package:mentormatch_apps/style/color_style.dart';

class BottomNavbarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  const BottomNavbarWidget({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ColorStyle().whiteColors,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_sharp),
          label: 'Class',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      // backgroundColor: const Color(0xFF2465ac),
      currentIndex: currentIndex,
      selectedItemColor: ColorStyle().primaryColors,
      unselectedItemColor: ColorStyle().disableColors,
      showUnselectedLabels: true,
      // selectedLabelStyle: ,
      onTap: onTap,
    );
  }
}
