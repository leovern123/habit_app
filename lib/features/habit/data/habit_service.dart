import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/habit_model.dart';
import '../../../core/utils/date_helper.dart';
import 'package:uas_flutter/service/notification_service.dart';
import 'package:uas_flutter/service/fcm_service.dart';

class HabitService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference<Map<String, dynamic>> _habitCollection =
      FirebaseFirestore.instance.collection('habits');

  String? get uid => _auth.currentUser?.uid;

  /// Inisialisasi FCM
  static void init() {
    FcmService.initFCM();
  }

  /// Ambil semua habit aktif
  Stream<List<Habit>> getHabits() {
    if (uid == null) return const Stream.empty();

    return _habitCollection
        .where('userId', isEqualTo: uid)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Habit.fromFirestore(doc.data(), doc.id)).toList());
  }

  /// Ambil semua habit (aktif + nonaktif)
  Stream<List<Habit>> getAllHabits() {
    if (uid == null) return const Stream.empty();

    return _habitCollection
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Habit.fromFirestore(doc.data(), doc.id)).toList());
  }

  /// Toggle habit ON/OFF hari ini
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
      await _firestore.collection('habit_logs').doc(query.docs.first.id).update({
        'isDone': value,
        'completedAt': Timestamp.now(),
        'dateTs': todayTs,
      });
    }
  }

  /// Toggle habit aktif/nonaktif
  Future<void> toggleActive(String habitId, bool isActive) async {
    if (uid == null) return;

    await _habitCollection.doc(habitId).update({
      'isActive': !isActive,
    });
  }

  /// Update habitTime + reschedule notif
  Future<void> updateHabitTime(String habitId, TimeOfDay time) async {
    if (uid == null) return;

    final now = DateTime.now();
    final newHabitDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // Update ke Firestore
    await _habitCollection.doc(habitId).update({
      'habitTime': Timestamp.fromDate(newHabitDateTime),
    });

    // Reschedule notif jika habit notificationOn
    final doc = await _habitCollection.doc(habitId).get();
    if (doc.exists && (doc.data()?['notificationOn'] ?? false)) {
      await NotificationService.scheduleDailyNotificationFromDateTime(
        id: habitId.hashCode,
        title: doc.data()?['title'] ?? 'Habit Reminder',
        habitTime: newHabitDateTime,
        payload: 'habit_$habitId',
      );
    }
  }

  /// Hapus habit + cancel notif
  Future<void> deleteHabit(String habitId) async {
    if (uid == null) return;

    await _habitCollection.doc(habitId).delete();
    await NotificationService.cancel(habitId.hashCode);
  }

  /// Buat habit baru (notif default ON)
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

  // Simpan ke Firestore
  final docRef = await _habitCollection.add({
    'title': title,
    'userId': uid,
    'isActive': true,
    'notificationOn': true,
    'createdAt': Timestamp.now(),
    'habitTime': Timestamp.fromDate(habitDateTime),
    'notifId': notifId, // 
  });

  // Jadwalkan notifikasi
  await NotificationService.scheduleDailyNotificationFromDateTime(
    id: notifId,
    title: title,
    habitTime: habitDateTime,
    payload: 'habit_${docRef.id}',
  );
}

Future<void> restoreAllNotifications() async {
  if (uid == null) return;

  final snapshot = await _habitCollection
      .where('userId', isEqualTo: uid)
      .where('notificationOn', isEqualTo: true)
      .get();

  for (var doc in snapshot.docs) {
    final data = doc.data();

    if (data['habitTime'] == null || data['notifId'] == null) continue;

    DateTime habitTime = (data['habitTime'] as Timestamp).toDate().toLocal();

    // 🔥 Kalau jam hari ini sudah lewat, geser ke besok
    final now = DateTime.now();
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



  /// Toggle notification ON/OFF
  Future<void> toggleNotification(Habit habit) async {
    final newValue = !habit.notificationOn;

    // update Firestore
    await _habitCollection.doc(habit.habitId).update({
      'notificationOn': newValue,
    });

    debugPrint('🔔 Habit "${habit.title}" notification set to: $newValue');

    if (newValue && habit.habitTime != null) {
      final habitDateTime = habit.habitTime!.toDate().toLocal();
      await NotificationService.scheduleDailyNotificationFromDateTime(
        id: habit.habitId.hashCode,
        title: habit.title,
        habitTime: habitDateTime,
        payload: 'habit_${habit.habitId}',
      );
    } else {
      await NotificationService.cancel(habit.habitId.hashCode);
    }
  }

  /// Ambil logs habit hari ini
  Stream<Map<String, bool>> getTodayLogs() {
    if (uid == null) return const Stream.empty();

    final today = DateHelper.today();

    return _firestore
        .collection('habit_logs')
        .where('userId', isEqualTo: uid)
        .where('date', isEqualTo: today)
        .snapshots()
        .map((snapshot) {
      final map = <String, bool>{};
      for (var doc in snapshot.docs) {
        map[doc['habitId']] = doc['isDone'] as bool;
      }
      return map;
    });
  }

  /// Logs bulan ini
  Stream<Map<String, bool>> getCurrentMonthLogsStream(String habitId) {
    if (uid == null) return const Stream.empty();

    final now = DateTime.now();
    final startOfMonth = Timestamp.fromDate(DateTime(now.year, now.month, 1));

    // perbaikan: bulan Desember
    final nextMonth = now.month < 12 ? now.month + 1 : 1;
    final nextMonthYear = now.month < 12 ? now.year : now.year + 1;
    final startOfNextMonth = Timestamp.fromDate(DateTime(nextMonthYear, nextMonth, 1));

    return _firestore
        .collection('habit_logs')
        .where('habitId', isEqualTo: habitId)
        .where('userId', isEqualTo: uid)
        .where('dateTs', isGreaterThanOrEqualTo: startOfMonth)
        .where('dateTs', isLessThan: startOfNextMonth)
        .snapshots()
        .map((snapshot) {
      final map = <String, bool>{};
      for (var doc in snapshot.docs) {
        map[doc['date'].toDate().day.toString()] = doc['isDone'] as bool;
      }
      return map;
    });
  }

  /// Logs 7 hari terakhir
  Stream<List<bool>> getLast7DaysLogsStream(String habitId) {
    if (uid == null) return const Stream.empty();

    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    return _firestore
        .collection('habit_logs')
        .where('habitId', isEqualTo: habitId)
        .where('userId', isEqualTo: uid)
        .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgo))
        .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(now))
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc['isDone'] as bool).toList());
  }

  /// Tes notif manual
  static void sendTestNotification() {
    NotificationService.showNotification(
      id: 999,
      title: 'Tes Habit',
      body: 'Ini adalah notifikasi percobaan',
      payload: 'test_999',
    );
  }
}
