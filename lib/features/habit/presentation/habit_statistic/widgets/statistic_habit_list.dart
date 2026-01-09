import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';

class StatisticHabitList extends StatelessWidget {
  final HabitService habitService;
  final DateTimeRange range;

  const StatisticHabitList({
    super.key,
    required this.habitService,
    required this.range,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habits')
          .where('userId', isEqualTo: habitService.uid)
          .snapshots(),
      builder: (context, habitSnapshot) {
        if (!habitSnapshot.hasData) return const SizedBox();

        final habits = habitSnapshot.data!.docs;

        return Column(
          children: habits.map((habit) {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('habit_logs')
                  .where('habitId', isEqualTo: habit.id)
                  .where('date', isGreaterThanOrEqualTo: range.start)
                  .where('date', isLessThan: range.end)
                  .snapshots(),
              builder: (context, logSnapshot) {
                if (!logSnapshot.hasData) return const SizedBox();

                final logs = logSnapshot.data!.docs;
                final done = logs.where((e) => e['isDone'] == true).length;

                return ListTile(
                  title: Text(habit['title']),
                  subtitle: Text('$done / ${logs.length} selesai'),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}