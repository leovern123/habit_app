import 'package:cloud_firestore/cloud_firestore.dart';

class DateHelper {
  static Timestamp today() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return Timestamp.fromDate(today);
  }
}