//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtil {
  NotificationUtil._();

  static NotificationUtil instance = NotificationUtil._();

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
      onDidReceiveNotificationResponse: didReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          didReceiveBackgroundNotificationResponse,
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
      'Anniversaire de Zoé Mauray !',
      'Dimanche 14 avril',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> scheduleBirthdayNotifications() async {
    final database = await DatabaseUtil.instance;
    final rows = await database
        .query('children', where: 'archived <= ?', whereArgs: [0]);
  }
}

@pragma('vm:entry-point')
Future<void> didReceiveNotificationResponse(
  NotificationResponse payload,
) async {
  debugPrint('onDidReceiveNotificationResponse: $payload');
}

@pragma('vm:entry-point')
Future<void> didReceiveBackgroundNotificationResponse(
  NotificationResponse payload,
) async {
  debugPrint('onDidReceiveBackgroundNotificationResponse: $payload');
}
