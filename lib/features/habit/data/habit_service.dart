import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/habit_model.dart';
import '../../../core/utils/date_helper.dart';
import 'package:uas_flutter/service/notification_service.dart';


class HabitService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference<Map<String, dynamic>> _habitCollection =
      FirebaseFirestore.instance.collection('habits');

  String? get uid => _auth.currentUser?.uid;

  Stream<List<Habit>> getHabits() {
    if (uid == null) return const Stream.empty();

    return _habitCollection
        .where('userId', isEqualTo: uid)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) =>
            s.docs.map((d) => Habit.fromFirestore(d.data(), d.id)).toList());
  }

  Stream<List<Habit>> getAllHabits() {
    if (uid == null) return const Stream.empty();

    return _habitCollection
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) =>
            s.docs.map((d) => Habit.fromFirestore(d.data(), d.id)).toList());
  }

  // ===============================
  // CREATE HABIT
  // ===============================
  Future<void> createHabit({
    required String title,
    required TimeOfDay time,
  }) async {
    if (uid == null) return;

    final now = DateTime.now();
    DateTime habitDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (habitDateTime.isBefore(now)) {
      habitDateTime = habitDateTime.add(const Duration(days: 1));
    }

    final notifId = DateTime.now().millisecondsSinceEpoch % 100000;

    final docRef = await _habitCollection.add({
      'title': title,
      'userId': uid,
      'isActive': true,
      'notificationOn': true,
      'createdAt': Timestamp.now(),
      'habitTime': Timestamp.fromDate(habitDateTime),
      'notifId': notifId,
    });

    await NotificationService.scheduleDailyNotificationFromDateTime(
      id: notifId,
      title: title,
      habitTime: habitDateTime,
      payload: 'habit_${docRef.id}',
    );
  }

  // ===============================
  // RESTORE NOTIFICATION
  // ===============================
  Future<void> restoreAllNotifications() async {
    if (uid == null) return;

    final snapshot = await _habitCollection
        .where('userId', isEqualTo: uid)
        .where('notificationOn', isEqualTo: true)
        .get();

    final now = DateTime.now();

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (data['habitTime'] == null || data['notifId'] == null) continue;

      DateTime habitTime = (data['habitTime'] as Timestamp).toDate().toLocal();

      if (habitTime.isBefore(now)) {
        habitTime = habitTime.add(const Duration(days: 1));
      }

      await NotificationService.scheduleDailyNotificationFromDateTime(
        id: data['notifId'],
        title: data['title'] ?? 'Habit Reminder',
        habitTime: habitTime,
        payload: 'habit_${doc.id}',
      );
    }

    debugPrint('🔁 All notifications restored');
  }

  // ===============================
  // TOGGLE NOTIFICATION
  // ===============================
  Future<void> toggleNotification(Habit habit) async {
    final newValue = !habit.notificationOn;

    await _habitCollection.doc(habit.habitId).update({
      'notificationOn': newValue,
    });

    if (newValue && habit.habitTime != null) {
      DateTime time = habit.habitTime!.toDate().toLocal();
      final now = DateTime.now();

      if (time.isBefore(now)) {
        time = time.add(const Duration(days: 1));
      }

      await NotificationService.scheduleDailyNotificationFromDateTime(
        id: habit.notifId!,
        title: habit.title,
        habitTime: time,
        payload: 'habit_${habit.habitId}',
      );
    } else {
      await NotificationService.cancel(habit.notifId!);
    }
  }

  Future<void> updateHabitTime(String habitId, TimeOfDay time) async {
    final doc = await _habitCollection.doc(habitId).get();
    if (!doc.exists) return;

    final data = doc.data()!;
    final notifId = data['notifId'];

    final now = DateTime.now();
    DateTime newTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (newTime.isBefore(now)) {
      newTime = newTime.add(const Duration(days: 1));
    }

    await _habitCollection.doc(habitId).update({
      'habitTime': Timestamp.fromDate(newTime),
    });

    if (data['notificationOn'] == true) {
      await NotificationService.scheduleDailyNotificationFromDateTime(
        id: notifId,
        title: data['title'],
        habitTime: newTime,
        payload: 'habit_$habitId',
      );
    }
  }

  Future<void> deleteHabit(String habitId) async {
    final doc = await _habitCollection.doc(habitId).get();
    final notifId = doc.data()?['notifId'];

    await _habitCollection.doc(habitId).delete();

    if (notifId != null) {
      await NotificationService.cancel(notifId);
    }
  }

  // ===============================
  // LOGS
  // ===============================
  Stream<Map<String, bool>> getTodayLogs() {
    if (uid == null) return const Stream.empty();

    final today = DateHelper.today();

    return _firestore
        .collection('habit_logs')
        .where('userId', isEqualTo: uid)
        .where('date', isEqualTo: today)
        .snapshots()
        .map((s) {
      final map = <String, bool>{};
      for (var doc in s.docs) {
        map[doc['habitId']] = doc['isDone'] as bool;
      }
      return map;
    });
  }

  // ===============================
  // TOGGLE DONE
  // ===============================
  Future<void> toggleHabit(String habitId, bool value) async {
    if (uid == null) return;

    final today = DateHelper.today();
    final now = DateTime.now();
    final onlyDate = DateTime(now.year, now.month, now.day);
    final Timestamp todayTs = Timestamp.fromDate(onlyDate);

    final query = await _firestore
        .collection('habit_logs')
        .where('userId', isEqualTo: uid)
        .where('habitId', isEqualTo: habitId)
        .where('date', isEqualTo: today)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      await _firestore.collection('habit_logs').add({
        'habitId': habitId,
        'userId': uid,
        'date': today,
        'dateTs': todayTs,
        'isDone': value,
        'completedAt': Timestamp.now(),
      });
    } else {
      await _firestore
          .collection('habit_logs')
          .doc(query.docs.first.id)
          .update({
        'isDone': value,
        'completedAt': Timestamp.now(),
        'dateTs': todayTs,
      });
    }
  }

  // ===============================
  // TOGGLE ACTIVE
  // ===============================
  Future<void> toggleActive(String habitId, bool isActive) async {
    await _habitCollection.doc(habitId).update({
      'isActive': !isActive,
    });
  }

  // ===============================
  // TEST
  // ===============================
  Future<void> scheduleTestNotification(DateTime time) async {
    await NotificationService.scheduleDailyNotificationFromDateTime(
      id: 9999,
      title: "ALARM TEST",
      habitTime: time,
      payload: "test",
    );
  }

  static void sendTestNotification() {
    NotificationService.showTestNow();
  }
}
