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

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      habitId: map['habitId'] as String,
      title: map['title'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as Timestamp,
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
