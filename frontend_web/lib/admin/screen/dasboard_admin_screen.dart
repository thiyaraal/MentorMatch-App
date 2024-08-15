import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/community_admin_screen.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/dasboard_home.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/mentee_admin.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/mentor_admin_screen.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/notification_admin_screen.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/pembayaran_admin_screen.dart';
import 'package:my_flutter_app/admin/screen/menu_admin/program_layanan_screen.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/sidebar_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardAdminScreen extends StatefulWidget {
  final String? selectedMenu; // Define the named parameter as optional

  DashboardAdminScreen({Key? key, this.selectedMenu}) : super(key: key);

  @override
  _DashboardAdminScreenState createState() => _DashboardAdminScreenState();
}

class _DashboardAdminScreenState extends State<DashboardAdminScreen>
    with SingleTickerProviderStateMixin {
  double _size = 250.0;
  bool _large = true;
  String _selectedMenu = 'Dashboard';

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  void _handleMenuSelected(String menu) {
    setState(() {
      _selectedMenu = menu;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedMenu = widget.selectedMenu ?? 'Dashboard';
    _loadProfileData();
  }

  String _name = "";
  String _photoUrl = "";

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "";
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(seconds: 1),
            child: SideBarAdmin(
              key: UniqueKey(),
              size: _size,
              onMenuSelected: _handleMenuSelected,
              selectedMenu: _selectedMenu,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black87),
                        onPressed: () {
                          _updateSize();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications_active,
                            color: ColorStyle().secondaryColors),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationAdminScreen(),
                            ),
                          );
                        },
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(_photoUrl),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  flex: 4,
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
          ),
        ],
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedMenu) {
      case 'Program & Layanan':
        return ProgramLayananContent();
      case 'Mentee':
        return MenteeScreen();
      case 'Mentor':
        return MentorScreen();
      case 'Community':
        return ComunityScreen();
      case 'Pembayaran':
        return PembayaranAdminScreen();
      default:
        return HomeScreenAdmin();
    }
  }
}
