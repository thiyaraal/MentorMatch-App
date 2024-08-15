import 'package:flutter/material.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/premiumClass/Karier_list_class.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/premiumClass/Kuliah_list_class.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/premiumClass/SD_list_class.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/premiumClass/SMA_list_class.dart';
import 'package:my_flutter_app/admin/screen/menu_program_layanan_admin/premiumClass/SMP_list_class.dart';
import 'package:my_flutter_app/widget/card/card_category_premium_class.dart';

class PremiumClassListAdminScreen extends StatefulWidget {
  PremiumClassListAdminScreen({Key? key}) : super(key: key);

  @override
  State<PremiumClassListAdminScreen> createState() =>
      _PremiumClassListAdminScreenState();
}

class _PremiumClassListAdminScreenState
    extends State<PremiumClassListAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CategoryCardPremiumClass(
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SDListPremiumClassAdminScreenState(),
                  ),
                );
              },
            text: "SD",
          ),
          CategoryCardPremiumClass(
            text: "SMP",
           onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SMPListPremiumClassAdminScreenState(),
                  ),
                );
              },
          ),
          CategoryCardPremiumClass(
            text: "SMA",
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SMAListPremiumClassAdminScreenState(),
                  ),
                );
              },
          ),
          CategoryCardPremiumClass(
            text: "Kuliah",
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KuliahListPremiumClassAdminScreenState(),
                  ),
                );
              },
          ),
          CategoryCardPremiumClass(
            text: "Karier",
           onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KarierListPremiumClassAdminScreenState(),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
