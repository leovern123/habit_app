import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Inisialisasi plugin + timezone
  static Future<void> init() async {
    tz.initializeTimeZones();

     final String localTz = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(localTz));

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const settings = InitializationSettings(android: androidSettings);

  await _plugin.initialize(settings);

  await _plugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  }

  /// Schedule notif berdasarkan DateTime Firestore
  static Future<void> scheduleDailyNotificationFromDateTime({
    required int id,
    required String title,
    required DateTime habitTime,
    required String payload,
  }) async {
    final loc = tz.local;

    tz.TZDateTime scheduled = tz.TZDateTime.from(habitTime, loc);

    
    final now = tz.TZDateTime.now(loc);
    if (scheduled.isBefore(now)) scheduled = scheduled.add(Duration(days: 1));

    debugPrint('🔔 Jadwal notif: $title => $scheduled');

    await _plugin.zonedSchedule(
      id,
      title,
      'Saatnya lakukan habit!',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_channel',
          'Habit Reminder',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, 
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
       matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  /// Batalkan notif berdasarkan id
  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
    debugPrint('❌ Notif dibatalkan id: $id');
  }

  /// Test notif manual
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: payload,
    );
    debugPrint('🔔 Test notif: $title - $body');
  }
}
