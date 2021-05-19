import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_helper.dart';
import 'package:http/http.dart' as http;

Future<dynamic> myBackgroundMessageHandler(
    Map<String, dynamic> notification) async {
  print("myBackgroundMessageHandler $notification");
  var notificationObject = FirebaseNotificationModel.fromMap(notification);
  NotificationHelper.showNotification(notificationObject);
}

class FirebaseMessagingHelper {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static void init() async {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> notification) async {
          var notificationObject =
              FirebaseNotificationModel.fromMap(notification);
          notificationObject.log();
          NotificationHelper.showNotification(notificationObject);
        },
        onBackgroundMessage:
            Platform.isAndroid ? myBackgroundMessageHandler : null,
        onLaunch: (Map<String, dynamic> notification) async {},
        onResume: (Map<String, dynamic> notification) async {});
    _firebaseMessaging.setAutoInitEnabled(true);
  }

  static Future<String> get getToken => _firebaseMessaging.getToken();

  static void sendNotification(
      String tokenID, String body, String title) async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAlKO-Kbo:APA91bF0Q1Sg23S64BpfMfEdTDefql1qIxcItna3Weab6QqznHYVZRLk-jUIffdOASfn9lPNXuXl4vkCj7ifzMFRRkmtJsz6ExPS1_4q14JOC_NGc7WVl6KRXMVXgwz5vzBq3jkutWZg',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': tokenID,
        },
      ),
    );
  }
}

class FirebaseNotificationModel {
  final String title;
  final String body;
  final String picture;
  final String link;

  FirebaseNotificationModel({this.title, this.body, this.picture, this.link});

  bool get hasPicture => picture != null;

  void log() {
    print("title: $title");
    print("body: $body");
    print("picture: $picture");
    print("link: $link");
  }

  factory FirebaseNotificationModel.fromMap(Map<String, dynamic> notification) {
    if (Platform.isAndroid) {
      return FirebaseNotificationModel(
          title: notification["notification"]["title"],
          body: notification["notification"]["body"],
          link: notification["data"]["link"],
          picture: notification["data"]["picture"]);
    } else {
      return FirebaseNotificationModel(
          title: notification["notification"]["title"],
          body: notification["notification"]["body"],
          link: notification["link"],
          picture: notification["picture"]);
    }
  }
}
