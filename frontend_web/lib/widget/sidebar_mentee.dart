import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/mentee/screen/landing_page.dart';
import 'package:my_flutter_app/preferences/%20preferences_helper.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:my_flutter_app/widget/show_dialog_widget.dart';

class SideBarMentee extends StatefulWidget {
  final double size;
  final void Function(String) onMenuSelected;
  final String selectedMenu;

  const SideBarMentee({
    required Key key,
    required this.size,
    required this.onMenuSelected,
    required this.selectedMenu,
  }) : super(key: key);

  @override
  State<SideBarMentee> createState() => _SideBarMenteeState();
}

class _SideBarMenteeState extends State<SideBarMentee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      color: ColorStyle().whiteColors,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMenuSideBar("Home", Icons.dashboard),
          _buildMenuSideBar("Class", Icons.menu_book_sharp),
          _buildMenuSideBar("Community", Icons.workspaces_filled),

          SizedBox(height: 260),

          _buildLogoutButton(),

          // Tambahkan item menu lain jika ada
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
                  await _googleSignIn.signOut();
                  await FirebaseAuth.instance.signOut();
                  await UserPreferences.clearPreferences();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
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
