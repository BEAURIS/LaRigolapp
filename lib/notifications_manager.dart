// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    tz.initializeTimeZones();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  }

  Future<void> scheduleDailyNotification() async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'daily_joke_channel', 'Daily Joke',
        importance: Importance.max, priority: Priority.high, showWhen: false);

    final iOSPlatformChannelSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Holà, c\'est déjà l\'heure de rigoler',
        'Viens voir la blague du jour !',
        _nextInstanceOfNoon(),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfNoon() {
    final now = tz.TZDateTime.now(tz.local);
    final noonToday = tz.TZDateTime(tz.local, now.year, now.month, now.day, 12);
    return now.isBefore(noonToday) ? noonToday : noonToday.add(const Duration(seconds: 10));
  }
}
