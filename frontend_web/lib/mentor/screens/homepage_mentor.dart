import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentee/screen/sidebar/community_user.dart';
import 'package:my_flutter_app/mentor/Screens/my_class_mentor/my_class_mentor_sidebar.dart';
import 'package:my_flutter_app/mentor/Screens/search_page_mentor.dart';
import 'package:my_flutter_app/mentor/screens/notification_mentor_screen.dart';
import 'package:my_flutter_app/mentor/screens/profile/mentor_profile_screen.dart';
import 'package:my_flutter_app/mentor/screens/sidebar/dashboard_mentor.dart';
import 'package:my_flutter_app/mentor/service/notification_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/footer.dart';
import 'package:my_flutter_app/widget/logo_button.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/sidebar_mentee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorHomePage extends StatefulWidget {
  final String selectedMenu;
  final String subMenu; // New parameter for sub-menu selection

  const MentorHomePage({
    super.key,
    this.selectedMenu = 'Home',
    this.subMenu = '', // Default value for sub-menu selection
  });

  @override
  State<MentorHomePage> createState() => _MentorHomePageState();
}

class _MentorHomePageState extends State<MentorHomePage> {
  String _photoUrl = "";
  String _name = "";
  String _namedepan = "";
  final double _size = 200.0;
  String _selectedMenu = '';
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationsCount = 0;

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
      //name
      _name = prefs.getString('name') ?? "";
      _namedepan = _name.split(' ')[0]; // Ambil bagian pertama (nama depan)
    });
  }

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
      if (kDebugMode) {
        print(e);
      } // Handle error appropriately
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _fetchUnreadNotificationsCount();

    _selectedMenu =
        widget.selectedMenu; // Tetapkan nilai _selectedMenu dari widget
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
              ButtonLogoMentorMatch(),
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationMentorScreen(),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileMentorScreen(),
                        ),
                      );
                    },
                    child: ClipOval(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/blank_profile.jpg',
                          fit: BoxFit.cover,
                        ),
                        imageUrl: _photoUrl,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
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
              const SearchBarMentor(),
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
              const SizedBox(
                height: 200,
              ),
              const FooterWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedMenu) {
      case 'Class':
        return MyClassMentorListScreen(
          initialSubMenu: widget.subMenu,
        );
      case 'Community':
        return const CommunityScreen();
      default:
        return const DashboardMentor();
    }
  }
}

class SearchBarMentor extends StatefulWidget {
  const SearchBarMentor({
    super.key,
  });

  @override
  _SearchBarMentorState createState() => _SearchBarMentorState();
}

class _SearchBarMentorState extends State<SearchBarMentor> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Search",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: const Color(0xff0A1737),
              fontSize: 16,
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPageMentorweb()),
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
                                builder: (context) => SearchPageMentorweb()),
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
