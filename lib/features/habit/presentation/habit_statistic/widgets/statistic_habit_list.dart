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
    final start = DateTime(range.start.year, range.start.month, range.start.day);
    final end = DateTime(range.end.year, range.end.month, range.end.day)
        .add(const Duration(days: 1));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habits')
          .where('userId', isEqualTo: habitService.uid)
          .where('isActive', isEqualTo: true)
          .snapshots(),
      builder: (context, habitSnapshot) {
        if (!habitSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final habits = habitSnapshot.data!.docs;

        if (habits.isEmpty) {
          return const Text(
            'Tidak ada habit aktif',
            style: TextStyle(color: Colors.grey),
          );
        }

        return Column(
          children: habits.map((habit) {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('habit_logs')
                  .where('habitId', isEqualTo: habit.id)
                  .where('userId', isEqualTo: habitService.uid)
                  .where('dateTs',
                      isGreaterThanOrEqualTo: Timestamp.fromDate(start))
                  .where('dateTs',
                      isLessThan: Timestamp.fromDate(end))
                  .snapshots(),
              builder: (context, logSnapshot) {
                if (!logSnapshot.hasData) {
                  return const SizedBox();
                }

                final logs = logSnapshot.data!.docs;
                final done =
                    logs.where((e) => e['isDone'] == true).length;

                final progress =
                    logs.isEmpty ? 0.0 : done / logs.length;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$done dari ${logs.length} hari',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
