import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/login/login_screen.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/show_dialog_widget.dart';

class SideBarAdmin extends StatefulWidget {
  final double size;
  final void Function(String) onMenuSelected;
  final String selectedMenu;

  SideBarAdmin({
    required Key key,
    required this.size,
    required this.onMenuSelected,
    required this.selectedMenu,
  }) : super(key: key);

  @override
  State<SideBarAdmin> createState() => _SideBarAdminState();
}

class _SideBarAdminState extends State<SideBarAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      color: ColorStyle().whiteColors,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Image.asset(
                    'assets/logo-1.png',
                  ),
                ),
              ),

              _buildMenuSideBar("Dashboard", Icons.dashboard),
              _buildMenuSideBar("Program & Layanan", Icons.menu_book),
              _buildMenuSideBar("Mentee", Icons.supervised_user_circle_rounded),
              _buildMenuSideBar("Mentor", Icons.emoji_people_rounded),
              _buildMenuSideBar("Community", Icons.workspaces_filled),
              _buildMenuSideBar("Pembayaran", Icons.payment),
              SizedBox(height: 260),
              _buildLogoutButton(),

              // Tambahkan item menu lain jika ada
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSideBar(String text, IconData icon) {
    final isSelected = widget.selectedMenu == text;
    final textColor =
        isSelected ? ColorStyle().primaryColors : ColorStyle().disableColors;
    final iconColor =
        isSelected ? ColorStyle().primaryColors : ColorStyle().disableColors;
    final backgroundColor =
        isSelected ? ColorStyle().secondaryColors.withOpacity(0.1) : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton.icon(
        onPressed: () => widget.onMenuSelected(text),
        icon: Icon(icon, color: iconColor),
        label: Text(text, style: TextStyle(color: textColor)),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  _buildLogoutButton() {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomConfirmationDialog(
                aksi: 'Keluar',
                aksi2: 'Batal',
                title: "Konfirmasi",
                content:
                    "Apakah kamu yakin ingin keluar dari aplikasi MentorMatch?",
                onConfirm: () async {
                  // Tulis logika logout Anda di sini
                  // Misalnya, membersihkan shared preferences dan navigasi ke halaman login
                  await _googleSignIn.signOut();
                  await FirebaseAuth.instance.signOut();
                  await UserPreferences.clearPreferences();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              );
            },
          );
        },
        icon: Icon(Icons.logout, color: ColorStyle().primaryColors),
        label:
            Text('Logout', style: TextStyle(color: ColorStyle().primaryColors)),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
