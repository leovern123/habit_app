import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/habit_model.dart';
import '../../../core/utils/date_helper.dart';

class HabitService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid;

  /// ambil semua habit user
  Stream<List<Habit>> getHabits() {
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

  /// toggle habit hari ini (ANTI DUPLIKAT)
  Future<void> toggleHabit(String habitId, bool value) async {
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
}
