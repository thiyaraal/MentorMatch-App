import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentor/screen/create_class_and_session/form_create_session.dart';
import 'package:mentormatch_apps/mentor/screen/daftar_mentor/syarat_ketentuan_daftar_mentor/persetujuan_create_class_mentor.dart.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';
import 'package:mentormatch_apps/widget/button.dart';
import 'package:mentormatch_apps/widget/carausel_home.dart';
import 'package:mentormatch_apps/widget/search_bar.dart';

class HomeMentorScreen extends StatefulWidget {
  const HomeMentorScreen({super.key});

  @override
  State<HomeMentorScreen> createState() => _HomeMentorScreenState();
}

class _HomeMentorScreenState extends State<HomeMentorScreen> {
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
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
      print(e); // Handle error appropriately
    }
  }

  final List<Map<String, String>> carouselData = [
    {
      'title': 'Hello,\nSelamat datang di MentorMatch',
      'description':
          'Mulailah membuat kelas yang akan membantu banyak orang. Jadi mentor dan berbagi ilmu Anda kepada generasi muda',
      'imagePath': 'assets/Handoff/ilustrator/hello.png'
    },
    {
      'title': 'Menjadi Inspirasi Bagi Generasi Muda',
      'description':
          'Berbagi pengalaman dan pengetahuan Anda untuk membantu generasi muda meraih impian mereka.',
      'imagePath': 'assets/Handoff/ilustrator/community.png'
    },
    {
      'title': 'Siap untuk membuat perubahan?',
      'description':
          'Dengan menjadi mentor, Anda memberikan ilmu inspiratif kepada generasi. Mulailah sekarang!',
      'imagePath': 'assets/Handoff/ilustrator/online_meeting.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/Handoff/logo/LogoMobile.png',
              width: 120,
              height: 120,
            ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Build Your Awesome Class",
                style: FontFamily().regularText.copyWith(
                      fontSize: 14,
                      color: ColorStyle().secondaryColors,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchBarWidgetMentor(
                  title: 'search by mentee name,or class name'),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              ),
              items: carouselData.map((data) {
                return CarouselCard(
                  title: data['title']!,
                  description: data['description']!,
                  imagePath: data['imagePath']!,
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "what's the mentor activity",
                style: FontFamily().regularText.copyWith(
                      fontSize: 16,
                      color: ColorStyle().primaryColors,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 0.0, left: 12.0, right: 12.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorStyle().tertiaryColors,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/Handoff/ilustrator/looking mentor.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            textAlign: TextAlign.end,
                            "Create your premium class",
                            style: FontFamily().boldText.copyWith(
                                color: ColorStyle().secondaryColors,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Premium class adalah kelas berbayar berkualitas tinggi. Kamu dapat membuat kelas ini untuk mentee yang ingin belajar secara mendalam di bidang tertentu.',
                            style: FontFamily().regularText.copyWith(
                                  fontSize: 10,
                                ),
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmallElevatedButton(
                              width: 150,
                              height: 38,
                              title: 'Buat Kelas',
                              style: FontFamily().buttonText.copyWith(
                                    fontSize: 12,
                                  ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PersetujuanPremiClassMentor(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 0.0, left: 12.0, right: 12.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorStyle().tertiaryColors,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/Handoff/ilustrator/learn together 2.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            textAlign: TextAlign.end,
                            "Create your session",
                            style: FontFamily().boldText.copyWith(
                                color: ColorStyle().secondaryColors,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Buatlah sesi inspiratifmu untuk berbagi ilmu dan pengalaman kepada banyak orang yang bersemangat untuk pengetahuan dan pertumbuhan pribadi.',
                            style: FontFamily().regularText.copyWith(
                                  fontSize: 10,
                                ),
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmallElevatedButton(
                              width: 150,
                              height: 38,
                              title: 'Buat Sesion',
                              style: FontFamily().buttonText.copyWith(
                                    fontSize: 12,
                                  ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FormCreateSessionScreen(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
