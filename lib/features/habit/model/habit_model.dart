import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/main.dart';

class Habit {
  final String habitId;
  final String title;
  final String userId;
  final Timestamp createdAt;
  final Timestamp? habitTime;
  final bool isActive;
  final bool notificationOn;
  final List<int> notificationDays;
  final int? notifId; 

  Habit({
    required this.habitId,
    required this.title,
    required this.userId,
    required this.createdAt,
    this.habitTime,
    required this.isActive,
     required this.notificationOn,
    required this.notificationDays,
    this.notifId, 
  });
/// Dipakai saat ambil dari Firestore (doc + id)
  factory Habit.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return Habit(
      habitId: id,
      title: data['title'] as String,
      userId: data['userId'] as String,
      createdAt: data['createdAt'] as Timestamp,
      habitTime: data['habitTime'] as Timestamp?,
       isActive: data['isActive'] ?? true,
      notificationOn: data['notificationOn'] ?? false,
      notificationDays: List<int>.from(data['notificationDays'] ?? []),
      notifId: data['notifId'], 

    );
  }
  /// Opsional: kalau map sudah mengandung habitId
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      habitId: map['habitId'] as String,
      title: map['title'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as Timestamp,
      habitTime: map['habitTime'] as Timestamp?,
      isActive: map['isActive'] as bool,
      notificationOn: map['notificationOn'] as bool,
      notificationDays: map['notificationDays'] as List<int>,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'title': title,
      'userId': userId,
      'createdAt': createdAt,
      if (habitTime != null) 'habitTime': habitTime, 
      'isActive': isActive,  
      'notificationOn': notificationOn,
      'notificationDays': notificationDays,  
    };
  }
  
}
