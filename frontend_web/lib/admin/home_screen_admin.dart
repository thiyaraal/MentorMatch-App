import 'package:flutter/material.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/card/card_active_widget_admin.dart';
import 'package:my_flutter_app/widget/card/card_admin_widget.dart';
import 'package:my_flutter_app/widget/menucategory.dart';

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
                  'Hai , Alexander',
                  style: FontFamily().regularText,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Hai , Alexander',
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
                    ? KelasContent()
                    : isMentorActive
                        ? MentorContent()
                        : isPembayaranActive
                            ? PembayaranContent()
                            : KelasContent()
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

class KelasContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 700,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle().tertiaryColors,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Kelas Content"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: ColorStyle().primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Lihat Detail"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PembayaranContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 700,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle().tertiaryColors,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Pembayaran Content"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: ColorStyle().primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Lihat Detail"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MentorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 700,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyle().tertiaryColors,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mentor Content"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: ColorStyle().primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Lihat Detail"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
