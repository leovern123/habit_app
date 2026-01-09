import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';

class StatisticWeeklyGrid extends StatelessWidget {
  final HabitService habitService;

  const StatisticWeeklyGrid({super.key, required this.habitService});
   @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habit_logs')
          .where('userId', isEqualTo: habitService.uid)
          .where('date', isGreaterThanOrEqualTo: start)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final logs = snapshot.data!.docs;

        return GridView.builder(
          shrinkWrap: true,
          itemCount: 7,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemBuilder: (context, i) {
            final day = start.add(Duration(days: i));
            final done = logs.any((e) =>
                (e['date'] as Timestamp).toDate().day == day.day &&
                e['isDone'] == true);

            return Icon(
              done ? Icons.check_circle : Icons.cancel,
              color: done ? Colors.green : Colors.red,
            );
          },
        );
      },
    );
  }
}
