import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/habit_model.dart';
import '../../../core/utils/date_helper.dart';

class HabitService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  /// ambil semua habit user
  Stream<List<Habit>> getHabits() {
    if (uid == null) {
      return const Stream.empty();
    }

    print('UID LOGIN (getHabits): $uid');

    return _firestore
        .collection('habits')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Habit.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  /// ambil log hari ini
  Stream<Map<String, bool>> getTodayLogs() {
    if (uid == null) {
      return const Stream.empty();
    }

    final today = DateHelper.today();
    print('UID LOGIN (getTodayLogs): $uid');

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

// Update habitTime untuk habit tertentu
  Future<void> updateHabitTime(String habitId, TimeOfDay time) async {
    if (uid == null) return;

    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    await _firestore.collection('habits').doc(habitId).update({
      'habitTime': Timestamp.fromDate(dateTime),
    });
  }
  /// toggle habit hari ini (ANTI DUPLIKAT)
  Future<void> toggleHabit(String habitId, bool value) async {
    if (uid == null) return;

    final today = DateHelper.today();

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
      });
    }
  }

/// Ambil logs habit untuk bulan ini sebagai Stream
  Stream<Map<String, bool>> getCurrentMonthLogsStream(String habitId) {
    if (uid == null) return const Stream.empty();

    final now = DateTime.now();
    final startOfMonth = Timestamp.fromDate(DateTime(now.year, now.month, 1));
    final startOfNextMonth = Timestamp.fromDate(DateTime(now.year, now.month + 1, 1));

    return _firestore
        .collection('habit_logs')
        .where('habitId', isEqualTo: habitId)
        .where('userId', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThan: startOfNextMonth)
        .snapshots()
        .map((snapshot) {
      final map = <String, bool>{};
      for (var doc in snapshot.docs) {
        map[doc['date'].toDate().day.toString()] = doc['isDone'] as bool;
      }
      return map;
    });
  }
   /// Ambil logs 7 hari terakhir sebagai Stream
  Stream<List<bool>> getLast7DaysLogsStream(String habitId) {
    if (uid == null) return const Stream.empty();

    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    return _firestore
        .collection('habit_logs')
        .where('habitId', isEqualTo: habitId)
        .where('userId', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgo))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(now))
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc['isDone'] as bool).toList());
  }
}