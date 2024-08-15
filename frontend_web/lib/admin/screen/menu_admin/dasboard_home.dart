import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/screen/menu_dasboard_admin/pengajuan_kelas_admin_screen.dart';
import 'package:my_flutter_app/admin/screen/menu_dasboard_admin/pengajuan_mentor_screen.dart';
import 'package:my_flutter_app/admin/screen/menu_dasboard_admin/pengajuan_pembayaran_admin_screen.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/card/card_active_widget_admin.dart';
import 'package:my_flutter_app/widget/card/card_admin_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenAdmin extends StatefulWidget {
  HomeScreenAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  bool isKelasActive = true;
  bool isMentorActive = false;
  bool isPembayaranActive = false; // Tambahkan variabel untuk card ketiga

  void _handleMenuSelected(String menu) {
    setState(() {
      if (menu == 'Pengajuan Kelas') {
        isKelasActive = true;
        isMentorActive = false;
        isPembayaranActive = false;
      } else if (menu == 'Pengajuan Mentor') {
        isKelasActive = false;
        isMentorActive = true;
        isPembayaranActive = false;
      } else if (menu == 'Pengajuan Pembayaran') {
        isKelasActive = false;
        isMentorActive = false;
        isPembayaranActive = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  String _name = "";

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hai , $_name',
                  style: FontFamily().titleText,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Welcome to Admin Dashboard',
                    style: FontFamily().regularText.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        )),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardActiveAdminWidget(
              onTap: () {
                _handleMenuSelected('Pengajuan Kelas');
              },
              image:
                  AssetImage('assets/Handoff/icon/adminIcon/Premium Class.png'),
              text: 'Pengajuan Kelas',
              isActive: isKelasActive,
            ),
            CardActiveAdminWidget(
              onTap: () {
                _handleMenuSelected('Pengajuan Mentor');
              },
              image: AssetImage('assets/Handoff/icon/adminIcon/Mentor.png'),
              text: 'Pengajuan Mentor',
              isActive: isMentorActive,
            ),
            CardActiveAdminWidget(
              onTap: () {
                _handleMenuSelected('Pengajuan Pembayaran');
              },
              image: AssetImage('assets/Handoff/icon/adminIcon/Payment.png'),
              text: 'Pengajuan Pembayaran',
              isActive: isPembayaranActive,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isKelasActive
                    ? PengajuanKelasAdminScreen()
                    : isMentorActive
                        ? PengajuanMentorAdminScreen()
                        : isPembayaranActive
                            ? PengajuanPembayaraAdminScreenState()
                            : PengajuanKelasAdminScreen()
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardDasboardRightAdmin(
                    text1: "Jumlah Mentee",
                    image:
                        AssetImage("assets/Handoff/icon/adminIcon/Mentee.png"),
                    text2: "180 Mentee"),
                CardDasboardRightAdmin(
                    text1: "Jumlah Mentee",
                    image:
                        AssetImage("assets/Handoff/icon/adminIcon/Mentor.png"),
                    text2: "180 Mentor"),
                CardDasboardRightAdmin(
                    text1: "Jumlah Mentee",
                    image: AssetImage(
                        "assets/Handoff/icon/adminIcon/Community.png"),
                    text2: "180 Komunitas")
              ],
            )
          ],
        )
      ],
    );
  }
}
