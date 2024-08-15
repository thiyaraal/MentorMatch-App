// To parse this JSON data, do
//
//     final notification = notificationFromMap(jsonString);

import 'dart:convert';

Notification notificationFromMap(String str) =>
    Notification.fromMap(json.decode(str));

String notificationToMap(Notification data) => json.encode(data.toMap());

class Notification {
  bool? error;
  String? message;
  List<NotificationElement>? notifications;

  Notification({
    this.error,
    this.message,
    this.notifications,
  });

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        error: json["error"],
        message: json["message"],
        notifications: json["notifications"] == null
            ? []
            : List<NotificationElement>.from(json["notifications"]!
                .map((x) => NotificationElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toMap())),
      };
}

class NotificationElement {
  String? id;
  String? userId;
  String? title;
  String? content;
  bool? isRead;
  String? createdAt;

  NotificationElement({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.isRead,
    this.createdAt,
  });

  factory NotificationElement.fromMap(Map<String, dynamic> json) =>
      NotificationElement(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        content: json["content"],
        isRead: json["isRead"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "title": title,
        "content": content,
        "isRead": isRead,
        "createdAt": createdAt,
      };
}
