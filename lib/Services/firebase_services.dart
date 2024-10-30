import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseServices {
  checkNotificationForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      if (message.notification != null) {
        // print('Message also contained a notification: ${message.notification}');
      }
      sendLocalNotification(message);
    });
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'this used for important notification',
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void firebaseInitServices() {
//    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    requestPermission();
    configureLocalNotification();
    creatNotificationChannel();
  }

  creatNotificationChannel() {
    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
      'chats', // id
      'Chats', // titleyout
      description: 'For showing messsage notification.', // description
      importance: Importance.high,
    );
  }

  void requestPermission() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  void configureLocalNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) async {
              // Handle notification received in foreground
            });

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  sendLocalNotification(RemoteMessage message) async {
    if (message.notification != null) {
      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        message.notification!.title, // Notification Title
        message.notification!.body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'service', // Non-null channel ID
          'Service', // Non-null channel name
          channelDescription: '', // Non-null channel description
          importance: Importance.max,
          priority: Priority.high,
        )),
        payload: 'Payload',
      );
    }
  }
}
