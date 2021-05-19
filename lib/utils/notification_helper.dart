import 'dart:io';

import 'package:kan_bagisi/utils/firebase_messaging_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationHelper {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void init() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings("app_icon");
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String initialURL) async {});
  }

  static void showNotification(FirebaseNotificationModel notificationObject) {
    if (notificationObject.hasPicture) {
      print("showBigPictureNotification");
      NotificationHelper.showBigPictureNotification(
          1,
          notificationObject.title,
          notificationObject.body,
          notificationObject.picture,
          notificationObject.link);
    } else {
      print("showNormal");
      NotificationHelper.showNormal(1, notificationObject.title,
          notificationObject.body, notificationObject.link);
    }
  }

  static Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print(title);
  }

  static Future<void> showNormal(
      int id, String title, String body, String payload) async {
    //var imageLocalPath = await _downloadAndSaveFile(imageURL, 'largeIcon');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "Channel_ID", "channel name", "channel description",
        importance: Importance.max,
        visibility: NotificationVisibility.public,
        priority: Priority.high,
        ticker: "test ticker");

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin
        .show(id, title, body, platformSpecifics, payload: payload);
  }

  static Future<void> showBigPictureNotification(int id, String title,
      String body, String pictureURL, String payload) async {
    final String bigPicturePath =
        await _downloadAndSaveFile(pictureURL, 'bigPicture.jpg');

    print(bigPicturePath);

    // Android
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      //largeIcon: FilePathAndroidBitmap(largeIconPath),
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('big text channel id',
            'big text channel name', 'big text channel description',
            styleInformation: bigPictureStyleInformation);

    // IOS
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
      IOSNotificationAttachment(bigPicturePath)
    ]);

    // Macos
    final MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(attachments: <MacOSNotificationAttachment>[
      MacOSNotificationAttachment(bigPicturePath)
    ]);

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(url);
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
