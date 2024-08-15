import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/screen/bottom_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/screen/premium_class/premium_class_screen.dart';
import 'package:mentormatch_apps/mentee/screen/session/session_screen.dart';
import 'package:mentormatch_apps/mentor/screen/notification_mentor_screen.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/style/font_style.dart';

class PopMenuButtonWidget extends StatefulWidget {
  final String title; // Tambahkan properti title

  PopMenuButtonWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<PopMenuButtonWidget> createState() => _PopMenuButtonWidgetState();
}

class _PopMenuButtonWidgetState extends State<PopMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      // add icon, by default "3 dot" icon
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.arrow_drop_down_outlined),
          Text(
            widget.title,
            style: FontFamily().regularText,
          ),
        ],
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Text("Premium Class"),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Text("Session"),
          ),
        ];
      },
      onSelected: (value) {
        // Handle the selected value
        switch (value) {
          case 0:
            // Navigasi ke halaman Premium Class
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PremiumClassScreen()),
              (route) => false,
            );
            break;
          case 1:
            // Navigasi ke halaman Session
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SessionScreen()),
              (route) => false,
            );
            break;
        }
      },
    );
  }
}

class AppBarPremiumClass extends StatefulWidget {
  final String title; // Tambahkan properti title
  AppBarPremiumClass({Key? key, required this.title}) : super(key: key);

  @override
  State<AppBarPremiumClass> createState() => _AppBarPremiumClassState();
}

class _AppBarPremiumClassState extends State<AppBarPremiumClass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<int>(
          // add icon, by default "3 dot" icon
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_drop_down_outlined),
              Text(
                widget.title, // Gunakan judul dari properti title
                style: FontFamily().regularText.copyWith(fontSize: 14),
              ),
            ],
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Premium Class",
                  style: FontFamily().regularText.copyWith(fontSize: 14),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Session",
                  style: FontFamily().regularText.copyWith(fontSize: 14),
                ),
              ),
            ];
          },
          onSelected: (value) {
            // Handle the selected value
            switch (value) {
              case 0:
                // Navigasi ke halaman Premium Class
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PremiumClassScreen()),
                  (route) => false,
                );
                break;
              case 1:
                // Navigasi ke halaman Session
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SessionScreen()),
                  (route) => false,
                );
                break;
            }
          },
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active,
              color: ColorStyle().secondaryColors,
            ))
      ],
    );
  }
}

class AppBarLogoNotif extends StatefulWidget {
  AppBarLogoNotif({Key? key}) : super(key: key);

  @override
  State<AppBarLogoNotif> createState() => _AppBarLogoNotifState();
}

class _AppBarLogoNotifState extends State<AppBarLogoNotif> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavbarMenteeScreen()),
            );
          },
          child: Image.asset('assets/Handoff/logo/LogoMobile.png'),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationMenteeScreen(),
              ),
            );
          },
          icon: Icon(Icons.notifications_none_outlined),
          color: ColorStyle().secondaryColors,
        )
      ],
    );
  }
}

class AppBarHomePage extends StatefulWidget {
  AppBarHomePage({Key? key}) : super(key: key);

  @override
  State<AppBarHomePage> createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage> {
  final NotificationService _notificationService = NotificationService();
  int _unreadNotificationsCount = 0;

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

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/Handoff/logo/LogoMobile.png',
          width: 120,
          height: 120,
        ),
        PopMenuButtonWidget(
          title: "Program & Layanan",
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
    );
  }
}