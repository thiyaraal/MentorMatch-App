import 'package:flutter/material.dart';
import 'package:mentormatch_apps/mentee/model/community_model.dart';
import 'package:mentormatch_apps/mentee/screen/notification_mentee_screen.dart';
import 'package:mentormatch_apps/mentee/service/community_service.dart';
import 'package:mentormatch_apps/mentor/service/notification_service.dart';
import 'package:mentormatch_apps/style/color_style.dart';
import 'package:mentormatch_apps/widget/card_community.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityMenteeScreen extends StatefulWidget {
  CommunityMenteeScreen({Key? key}) : super(key: key);

  @override
  State<CommunityMenteeScreen> createState() => _CommunityMenteeScreenState();
}

class _CommunityMenteeScreenState extends State<CommunityMenteeScreen> {
  int _unreadNotificationsCount = 0;
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

  @override
  void initState() {
    super.initState();
    _fetchUnreadNotificationsCount();
  }

  Future<void> _launchURL(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak dapat membuka $urlString';
      }
    } catch (e) {
      throw 'URL tidak valid: $urlString';
    }
  }

  final CommunityService communityService = CommunityService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyle().whiteColors,
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
      body: FutureBuilder<CommunityModels>(
        future: communityService.fetchCommunities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final communityList = snapshot.data?.communities;
            if (communityList == null || communityList.isEmpty) {
              return const Center(
                child: Text('No communities available.'),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: communityList.length,
                      itemBuilder: (context, index) {
                        var community = communityList[index];
                        return Column(
                          children: [
                            CardCommunity(
                              title: community.name ?? '',
                              imagePath: community.imageUrl ?? '',
                              onPressed: () {
                                final communityUrl = community.link ?? '';
                                _launchURL(communityUrl);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            }
          }
        },
      ),
    );
  }
}
