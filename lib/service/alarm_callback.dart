import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _plugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void alarmCallback() async {
  print("⏰ ALARM FIRED");

  const android = AndroidNotificationDetails(
    'habit_channel',
    'Habit Reminder',
    channelDescription: 'Daily habit reminders',
    importance: Importance.max,
    priority: Priority.high,
  );

  const notif = NotificationDetails(android: android);

  await _plugin.show(
    0,
    'Habit Alarm',
    'Waktunya menjalankan habit',
    notif,
  );
}
