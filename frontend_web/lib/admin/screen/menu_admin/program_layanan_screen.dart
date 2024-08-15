import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/premiumClass/premium_class_admin.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/sessionClass/session_class_admin.dart';
import 'package:my_flutter_app/widget/card/card_active_widget_admin.dart';


class ProgramLayananContent extends StatefulWidget {
  @override
  State<ProgramLayananContent> createState() => _ProgramLayananContentState();
}

class _ProgramLayananContentState extends State<ProgramLayananContent> {
  bool isKelasActive = true;
  bool isMentorActive = false;
  bool isPembayaranActive = false;
  ////////////////////////////////
  void _handleMenuSelected(String menu) {
    setState(() {
      if (menu == 'Premium Class') {
        isKelasActive = true;
        isMentorActive = false;
        isPembayaranActive = false;
      } else if (menu == 'Session') {
        isKelasActive = false;
        isMentorActive = true;
        isPembayaranActive = false;
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardActiveAdminWidget(
                    onTap: () {
                      _handleMenuSelected('Premium Class');
                    },
                    image: AssetImage(
                        'assets/Handoff/icon/adminIcon/Premium Class.png'),
                    text: 'Premium Class',
                    isActive: isKelasActive,
                  ),
                  const SizedBox(width: 24),
                  CardActiveAdminWidget(
                    onTap: () {
                      _handleMenuSelected('Session');
                    },
                    image:
                        AssetImage('assets/Handoff/icon/adminIcon/Mentor.png'),
                    text: 'Session',
                    isActive: isMentorActive,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isKelasActive
                      ? PremiumClassListAdminScreen()
                      : isMentorActive
                          ? SessionAdminListScreen()
                          : PremiumClassListAdminScreen()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
