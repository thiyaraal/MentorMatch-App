import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mentormatch_apps/style/base_url.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> sendTokenToServer(String token, String userId) async {
  try {
    Dio dio = Dio();
    var response = await dio.post(
      '$baseUrl/save-token',
      data: {
        'token': token,
        'userId': userId,
      },
    );
    if (response.statusCode == 200) {
      print('Token sent to server successfully');
    } else {
      print(
          'Failed to send token to server, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending token to server: $e');
  }
}

class FCMService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request notification permissions
    if (await Permission.notification.request().isGranted) {
      // Initialize local notifications
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
          // Handle notification tap
          print('Notification tapped with payload: ${response.payload}');
        },
      );

      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      String? token = await messaging.getToken();
      print('FCM Token: $token');
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      if (userId != null && token != null) {
        await sendTokenToServer(token, userId);
      }

      messaging.onTokenRefresh.listen((newToken) async {
        print('New FCM Token: $newToken');
        if (userId != null) {
          await sendTokenToServer(newToken, userId);
        }
      });
    } else {
      print('Notification permission denied');
    }
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            importance: Importance.high,
          ),
        ),
      );
    }
  }

  static Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    // Handle notification tapped when app is in background or terminated
    print('Message clicked!');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }
}
