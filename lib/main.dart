import 'firebase_options.dart';
import 'package:lacrima/lacrima.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lacrima/shared/local/cache_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lacrima/shared/local/local_auth/local_auth.dart';
import 'package:lacrima/shared/notifications/local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  LocalNotificationService.initialize();
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(Lacrima(startScreen: usersAuth()));
}
