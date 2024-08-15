import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentee/screen/notification_mentee_screen.dart';
import 'package:my_flutter_app/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:my_flutter_app/mentee/screen/search_page_myclass_mentee.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/community_user.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/dashboard_mentee.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/my_class/my_class_mentee_sidebar.dart';
import 'package:my_flutter_app/mentor/service/notification_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/footer.dart';
import 'package:my_flutter_app/widget/logo_button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/navbaruser.dart';
import 'package:my_flutter_app/widget/sidebar_mentee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenteeHomePage extends StatefulWidget {
  final String selectedMenu;
  final String subMenu; // New parameter for sub-menu selection

  const MenteeHomePage({
    super.key,
    this.selectedMenu = 'Home',
    this.subMenu = '',
  });
  @override
  State<MenteeHomePage> createState() => _MenteeHomePageState();
}

class _MenteeHomePageState extends State<MenteeHomePage> {
  String _name = "";
  String _namedepan = "";
  String _photoUrl = "";
  final double _size = 200.0;
  String _selectedMenu = '';
  int _unreadNotificationsCount = 0;

  final NotificationService _notificationService = NotificationService();

  Future<void> _fetchUnreadNotificationsCount() async {
    try {
      final notifications =
          await _notificationService.fetchNotificationsForCurrentUser();
      final unreadCount =
          notifications.where((notification) => !notification.isRead!).length;
      setState(() {
        _unreadNotificationsCount = unreadCount;
      });
    } catch (e) {
      print(e); // Handle error appropriately
    }
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _name = prefs.getString('name') ?? "";
      _namedepan = _name.split(' ')[0]; // Ambil bagian pertama (nama depan)
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _fetchUnreadNotificationsCount();

    _selectedMenu = widget.selectedMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().whiteColors,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ButtonLogoMenteeMatch(),
                  const SizedBox(width: 20),
                ],
              ),
              Row(
                children: [
                  CustomDropdown(
                    title: 'Program dan Layanan',
                  ),
                  const SizedBox(width: 20),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationMenteeScreen(),
                            ),
                          ).then((_) {
                            _fetchUnreadNotificationsCount(); // Fetch the unread count when returning to this screen
                          });
                        },
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                        ),
                        color: ColorStyle().secondaryColors,
                      ),
                      if (_unreadNotificationsCount > 0)
                        Positioned(
                          right: 11,
                          top: 11,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              '$_unreadNotificationsCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileMenteeScreen()
                                // ProfileMentorScreen(),
                                ),
                          );
                        },
                        child: _buildCircularImage(
                          _photoUrl,
                          40,
                          40,
                          null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: SizedBox(
                          child: Text(
                            "Hallo, \n$_namedepan",
                            style: FontFamily().boldText.copyWith(
                                  color: ColorStyle().blackColors,
                                ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBarMentee(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SideBarMentee(
                      key: UniqueKey(),
                      size: _size,
                      onMenuSelected: (menu) {
                        setState(() {
                          _selectedMenu = menu;
                        });
                      },
                      selectedMenu: _selectedMenu),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, right: 16.0),
                        child: _getSelectedScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              const FooterWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        // error eiget use image from assets
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedMenu) {
      case 'Class':
        return MyClassMentee(
          initialSubMenu: widget.subMenu, // Pass the sub-menu parameter
        );
      case 'Community':
        return const CommunityScreen();
      default:
        return const DashboardMentee();
    }
  }
}

class SearchBarMentee extends StatefulWidget {
  const SearchBarMentee({
    super.key,
  });

  @override
  State<SearchBarMentee> createState() => _SearchBarMenteeState();
}

class _SearchBarMenteeState extends State<SearchBarMentee> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Search",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: const Color(0xff0A1737),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width:
                32, // Adjust this value to give some space between the text and the search bar
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPageMenteeWeb()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      isHovered = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      isHovered = false;
                    });
                  },
                  child: Container(
                    width: 800,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorStyle().tertiaryColors),
                      borderRadius: BorderRadius.circular(8),
                      color: isHovered ? Colors.grey[200] : Colors.white,
                    ),
                    child: AbsorbPointer(
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPageMenteeWeb()),
                          );
                        },
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText:
                              'Search by mentee name, class, or class name',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
