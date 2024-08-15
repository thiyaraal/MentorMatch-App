import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/community_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/home_screen_mentee.dart';
import 'package:mentormatch_apps/mentee/screen/my_class_mentee/my_class_list_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:mentormatch_apps/widget/bottom_nav.dart';

class BottomNavbarMenteeScreen extends StatefulWidget {
  final int? activeScreen;
  final String subMenu; // New parameter for sub-menu selection

  const BottomNavbarMenteeScreen(
      {super.key, this.activeScreen, this.subMenu = ''});

  @override
  State<BottomNavbarMenteeScreen> createState() =>
      _BottomNavbarMenteeScreenState();
}

class _BottomNavbarMenteeScreenState extends State<BottomNavbarMenteeScreen> {
  int _selectedNavbar = 0;

  @override
  void initState() {
    super.initState();
    // Jika activeScreen disetel, gunakan nilainya sebagai layar aktif
    if (widget.activeScreen != null) {
      _selectedNavbar = widget.activeScreen!;
    }
  }

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Widget screenBottomNavigation(int index) {
    if (index == 0) {
      return HomeMenteeScreen();
    } else if (index == 1) {
      return MyClassMenteeListScreen(
        subMenu: widget.subMenu,
      );
    } else if (index == 2) {
      return CommunityMenteeScreen();
    } else {
      return ProfileMenteeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        child: screenBottomNavigation(_selectedNavbar),
      ),
      bottomNavigationBar: BottomNavbarWidget(
        currentIndex: _selectedNavbar,
        onTap: _changeSelectedNavbar,
      ),
    );
  }
}
