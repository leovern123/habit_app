import 'package:cloud_firestore/cloud_firestore.dart';

class HabitLogModel {
  final String id;
  final String habitId;
  final bool isDone;
  final Timestamp date;

  HabitLogModel({
    required this.id,
    required this.habitId,
    required this.isDone,
    required this.date,
  });

  factory HabitLogModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return HabitLogModel(
      id: id,
      habitId: data['habitId'],
      isDone: data['isDone'],
      date: data['date'],
    );
  }
}
