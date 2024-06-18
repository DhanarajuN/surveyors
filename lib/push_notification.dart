import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize(BuildContext context) async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(
      initializationSettings,
      //   onSelectNotification: (String? route) async {
      // if (route != null) {
      //   Navigator.of(context).pushNamed(route);
      // }
      //}
    );
  }

static void display(RemoteMessage message) async {
  try {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
      "easyapproach",
      "easyapproach channel",
   //   "Notification channel for Easy Approach app",
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      // Add the flags here
   //   category: 'alarm', // or any appropriate category
      fullScreenIntent: true, // or false based on your requirement
    ));

    await _notificationsPlugin.show(
      id,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data["route"],
    );
  } on Exception catch (e) {
    print(e);
  }
}

}
