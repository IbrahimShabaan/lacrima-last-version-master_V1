import 'dart:convert' show jsonEncode;
import 'package:http/http.dart' as http;
import 'package:lacrima/shared/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  // ================== Subscribe To Topic ================
  static Future subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  // ================== UnSubscribe From Topic ================
  static Future unSubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  // ================== Send Notification To Token ================
  static Future sendNotificationToToken({
    required String token,
    required String title,
    required String body,
  }) async {
    Map<String, String> data = {
      'id': '1',
      'status': 'done',
      'message': title,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    };
    await http.post(
      Uri.parse(ConstText.baseUrl),
      headers: ConstText.headers,
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'priority': 'high',
          'data': data,
          'to': token
        },
      ),
    );
  }

  // ================== Send Notification To Topic ================
  static Future sendNotificationToTopic({
    required String topic,
    required String title,
    required String body,
  }) async {
    Map<String, String> data = {
      'id': '1',
      'status': 'done',
      'message': title,
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    };
    await http.post(
      Uri.parse(ConstText.baseUrl),
      headers: ConstText.headers,
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'priority': 'high',
          'data': data,
          'to': '/topics/$topic',
        },
      ),
    );
  }
}
