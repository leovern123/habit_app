import 'package:cloud_firestore/cloud_firestore.dart';

class DateHelper {
  static Timestamp today() {
    final now = DateTime.now();
    final dateOnly = DateTime(now.year, now.month, now.day);
    return Timestamp.fromDate(dateOnly);
  }

   static String formattedToday() {
    final now = DateTime.now();
    const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    return '${days[now.weekday % 7]}, '
           '${now.day}/${now.month}/${now.year}';
  }
}
