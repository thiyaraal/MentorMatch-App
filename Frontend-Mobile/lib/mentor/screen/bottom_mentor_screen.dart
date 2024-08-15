import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/bottom_home_mentor/home_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/my_class_mentor/my_class_list_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/community_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/screen/profile_mentor/mentor_profile_screen.dart';
import 'package:mentormatch_apps/widget/bottom_nav.dart';

class BottomNavbarMentorScreen extends StatefulWidget {
  final int? activeScreen;
  const BottomNavbarMentorScreen({Key? key, this.activeScreen})
      : super(key: key);

  @override
  State<BottomNavbarMentorScreen> createState() =>
      _BottomNavbarMentorScreenState();
}

class _BottomNavbarMentorScreenState extends State<BottomNavbarMentorScreen> {
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
      return const HomeMentorScreen();
    } else if (index == 1) {
      return MyClassMentorListScreen();
    } else if (index == 2) {
      return CommunityMentorScreen();
    } else {
      return MentorProfileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
