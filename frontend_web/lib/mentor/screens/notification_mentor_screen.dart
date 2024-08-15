import 'package:flutter/material.dart';
import 'package:my_flutter_app/mentor/model/notification_model.dart';
import 'package:my_flutter_app/mentor/service/notification_service.dart';
import 'package:my_flutter_app/style/fontStyle.dart';
import 'package:my_flutter_app/widget/menucategory.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationMentorScreen extends StatefulWidget {
  NotificationMentorScreen({Key? key}) : super(key: key);

  @override
  State<NotificationMentorScreen> createState() =>
      _NotificationMentorScreenState();
}

class _NotificationMentorScreenState extends State<NotificationMentorScreen> {
  final NotificationService _notificationService = NotificationService();
  late Future<List<NotificationElement>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture =
        _notificationService.fetchNotificationsForCurrentUser();
  }

  void _markAsRead(NotificationElement notification) async {
    if (!notification.isRead!) {
      try {
        await _notificationService.markNotificationAsRead(notification.id!);
        setState(() {
          notification.isRead = true;
        });
      } catch (e) {
        // Handle the error appropriately
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification", style: FontFamily().titleText),
      ),
      body: FutureBuilder<List<NotificationElement>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load notifications'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final DateTime createdAt =
                  DateTime.parse(notification.createdAt!);
              final DateTime now = DateTime.now();
              final Duration diff = now.difference(createdAt);

              String timeAgo;
              if (diff.inDays > 2) {
                timeAgo =
                    "${createdAt.year}-${createdAt.month}-${createdAt.day}";
              } else {
                timeAgo = timeago.format(createdAt);
              }

              return GestureDetector(
                onTap: () {
                  _markAsRead(notification);
                  // You can add additional action when the notification is clicked
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: notification.isRead!
                          ? ColorStyle().tertiaryColors
                          : ColorStyle().secondaryColors.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notification_add,
                          size: 36,
                          color: ColorStyle().primaryColors,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title ?? 'No Title',
                                  style: FontFamily().boldText.copyWith(
                                      fontSize: 16,
                                      color: ColorStyle().secondaryColors),
                                ),
                                Text(
                                  notification.content ?? 'No Content',
                                  style: FontFamily().regularText,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  timeAgo,
                                  style: FontFamily().regularText.copyWith(
                                      fontSize: 12,
                                      color: ColorStyle().secondaryColors),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
