//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:nannyplus/utils/prefs_util.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtil {
  NotificationUtil._();

  static NotificationUtil instance = NotificationUtil._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        debugPrint('onDidReceiveLocalNotification: $payload');
      },
    );

    final initializationSettings = InitializationSettings(
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
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
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

  Future<void> scheduleNotification(
    int serial,
    DateTime dateTime,
    String title,
    String body,
  ) async {
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      serial,
      'Anniversaire de Zoé Mauray !',
      'Dimanche 14 avril',
      tz.TZDateTime.from(dateTime, tz.local),
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
    await PrefsUtil.getInstance();
    final database = await DatabaseUtil.instance;

    final rows = await database
        .query('children', where: 'archived <= ?', whereArgs: [0]);

    final formatter = DateFormat('yyyy-MM-dd');
    final today = formatter.format(DateTime.now());
    final now = DateTime.now();
    final yyyy = now.year;

    final children = rows
        .map(Child.fromMap)
        .where((child) => child.birthdate != null)
        .map((child) {
      var newDate = '$yyyy-${child.birthdate!.substring(5)}';
      if (newDate.compareTo(today) < 0) {
        newDate = '${yyyy + 1}-${child.birthdate!.substring(5)}';
      }
      return child.copyWith(birthdate: newDate);
    }).toList()
      ..sort((a, b) => a.birthdate!.compareTo(b.birthdate!));

    var serial = 1;

    for (final birthdayChild in children) {
      final twoWeeksPrior = formatter
          .parse(birthdayChild.birthdate!)
          .add(const Duration(days: -14));

      final oneWeekPrior = formatter
          .parse(birthdayChild.birthdate!)
          .add(const Duration(days: -7));

      if (twoWeeksPrior.isAfter(now)) {
        await scheduleNotification(
          serial++,
          twoWeeksPrior,
          'Anniversaire de ${birthdayChild.displayName}',
          'Dans 2 semaines',
        );
      }
      if (oneWeekPrior.isAfter(now)) {
        await scheduleNotification(
          serial++,
          oneWeekPrior,
          'Anniversaire de ${birthdayChild.displayName}',
          'Dans 1 semaine',
        );
      }
    }
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
