import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _plugin.initialize(settings);

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // Permission Android 13+
    await androidPlugin?.requestNotificationsPermission();

    // Channel wajib
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'habit_channel',
        'Habit Reminder',
        description: 'Pengingat kebiasaan harian',
        importance: Importance.max,
      ),
    );
  }
  static Future<void> scheduleDailyNotificationFromDateTime({
    required int id,
    required String title,
    required DateTime habitTime,
    required String payload,
  }) async {
    final tzTime = tz.TZDateTime.from(habitTime, tz.local);

    await _plugin.zonedSchedule(
      id,
      title,
      'Saatnya lakukan habit kamu 🔔',
      tzTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_channel',
          'Habit Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, 
    );

    print("🔔 NOTIFICATION SET: $tzTime");
  }

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  static Future<void> showTestNow() async {
    await _plugin.show(
      999,
      'TEST',
      'Kalau ini muncul berarti sistem OK 🔔',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_channel',
          'Habit Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
