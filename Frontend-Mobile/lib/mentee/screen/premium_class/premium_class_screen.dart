import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/karier/karier_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/kuliah/kuliah_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sd/sd_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/sma/SMA_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/smp/SMP_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_premium_class.dart';
import 'package:mentormatch_apps/widget/navbar.dart';

class PremiumClassScreen extends StatefulWidget {
  const PremiumClassScreen({Key? key}) : super(key: key);

  @override
  State<PremiumClassScreen> createState() => _PremiumClassScreenState();
}

class _PremiumClassScreenState extends State<PremiumClassScreen> {
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

  int _unreadNotificationsCount = 0;
  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavbarMenteeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Image.asset(
                'assets/Handoff/logo/LogoMobile.png',
                width: 120,
                height: 120,
              ),
            ),
            PopMenuButtonWidget(
              title: "Premium Class",
            ),
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
                  icon: Icon(Icons.notifications_none_outlined),
                  color: ColorStyle().secondaryColors,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$_unreadNotificationsCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SDScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/SD.png',
                  description:
                      'Nikmati pembelajaran yang lebih baik dengan dukungan khusus dari mentor untuk tingkat SD yang membantu Anda dalam proses pembelajaran.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SMPScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/SMP.png',
                  description:
                      'Nikmati bimbingan personal dari mentor ahli yang akan membimbing Anda dalam memahami pelajaran dan membuka wawasan baru.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SMAScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/SMA.png',
                  description:
                      'Dapatkan dukungan khusus dari mentor kami untuk pembelajaran yang optimal dan persiapan ujian perguruan tinggi yang sukses.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KuliahScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/KULIAH.png',
                  description:
                      'Dapatkan panduan khusus dari mentor mahasiswa kami untuk meraih keberhasilan akademis dan persiapkan diri Anda untuk masa depan karier yang cemerlang.',
                ),
                CardPremiumClassOptions(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KarierScreen(),
                      ),
                    );
                  },
                  image: 'assets/Handoff/education_level/KARIER.png',
                  description:
                      'Temukan dukungan khusus dari mentor profesional kami untuk merancang dan mengembangkan karier Anda.',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
