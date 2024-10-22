import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const String icon = '@mipmap/ic_launcher';
    InitializationSettings initializationSettings =
        InitializationSettings(
      android: const AndroidInitializationSettings(icon),
      // iOS: IOSInitializationSettings(
      //   requestSoundPermission: false,
      //   requestBadgePermission: false,
      //   requestAlertPermission: false,
      // ),
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      int id = Random().nextInt(100000);
      NotificationDetails notificationDetails = NotificationDetails(
        android: const AndroidNotificationDetails(
          "ChanelOne",
          "MyChanel",
          priority: Priority.high,
          importance: Importance.max,
          channelShowBadge: true,
          enableVibration: true,
        ),
        // iOS: IOSNotificationDetails(
        //   presentAlert: true,
        //   presentBadge: true,
        //   presentSound: true,
        // ),
      );
      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
