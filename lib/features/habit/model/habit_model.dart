import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String habitId;
  final String title;
  final String userId;
  final Timestamp createdAt;

  Habit({
    required this.habitId,
    required this.title,
    required this.userId,
    required this.createdAt,
  });

/// ambil dari Firestore (doc + id)
  factory Habit.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return Habit(
      habitId: id,
      title: data['title'] as String,
      userId: data['userId'] as String,
      createdAt: data['createdAt'] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'title': title,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
