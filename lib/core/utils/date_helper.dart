import 'package:cloud_firestore/cloud_firestore.dart';

class DateHelper {
  /// Mengembalikan Timestamp hari ini tanpa jam, menit, detik
  static Timestamp today() {
    final now = DateTime.now();
    final dateOnly = DateTime(now.year, now.month, now.day);
    return Timestamp.fromDate(dateOnly);
  }
}
