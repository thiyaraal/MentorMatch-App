import 'package:dio/dio.dart';
import 'package:my_flutter_app/mentor/model/notification_model.dart';
import 'package:my_flutter_app/style/baseURl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final Dio _dio = Dio();

  // Fetch all notifications for the current user
  Future<List<NotificationElement>> fetchNotificationsForCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final userId = prefs.getString('userId') ?? '';

    try {
      _dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await _dio.get('$baseUrl/notifications/$userId');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            response.data; // Ensure response data is a map
        final notification = Notification.fromMap(data);
        if (notification.notifications != null) {
          return notification.notifications!;
        } else {
          throw Exception("Notification data not found");
        }
      } else {
        throw Exception("Failed to load notifications");
      }
    } catch (e) {
      print(e); // Use appropriate logging
      throw Exception("Failed to load notifications: $e");
    }
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      await _dio.patch(
        '$baseUrl/notifications/$notificationId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
    } catch (e) {
      print(e); // Use appropriate logging
      throw Exception("Failed to mark notification as read: $e");
    }
  }
}
