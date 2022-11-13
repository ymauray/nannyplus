import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtil {
  factory NotificationUtil() {
    return _singleton;
  }
  NotificationUtil._internal();
  static final NotificationUtil _singleton = NotificationUtil._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        debugPrint('onDidReceiveLocalNotification: $payload');
      },
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        debugPrint('onDidReceiveNotificationResponse: $payload');
      },
      onDidReceiveBackgroundNotificationResponse: (payload) async {
        debugPrint('onDidReceiveBackgroundNotificationResponse: $payload');
      },
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> sendNotification() async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'nannyplus',
      'Nanny+',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Ticker',
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Facture à payer !',
      'Vous avez une facture à payer !',
      platformChannelSpecifics,
      payload: 'Item x',
    );

    debugPrint('Ok !');
  }

  Future<void> scheduleNotification() async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'nannyplus',
      'Nanny+',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Ticker',
      visibility: NotificationVisibility.public,
      fullScreenIntent: true,
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
