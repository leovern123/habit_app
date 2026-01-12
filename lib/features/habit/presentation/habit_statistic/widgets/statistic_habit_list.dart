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

    final now = DateTime.now();
    final isToday =
        start.year == now.year &&
        start.month == now.month &&
        start.day == now.day &&
        end.difference(start).inDays == 1;

    final emptyText = isToday
        ? 'Tidak ada aktivitas hari ini'
        : 'Tidak ada aktivitas pada rentang waktu ini';

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

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('habit_logs')
              .where('userId', isEqualTo: habitService.uid)
              .where('dateTs',
                  isGreaterThanOrEqualTo: Timestamp.fromDate(start))
              .where('dateTs', isLessThan: Timestamp.fromDate(end))
              .snapshots(),
          builder: (context, logSnapshot) {
            if (!logSnapshot.hasData) {
              return const SizedBox();
            }

            final allLogs = logSnapshot.data!.docs;

            final activeHabitIds = habits.map((e) => e.id).toSet();
            final filteredLogs = allLogs
                .where((log) => activeHabitIds.contains(log['habitId']))
                .toList();

            if (filteredLogs.isEmpty) {
              return Text(
                emptyText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              );
            }

            return Column(
              children: habits.map((habit) {
                final logs = filteredLogs
                    .where((log) => log['habitId'] == habit.id)
                    .toList();

                if (logs.isEmpty) {
                  return const SizedBox();
                }

                final done =
                    logs.where((e) => e['isDone'] == true).length;
                final progress = done / logs.length;

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
              }).toList(),
            );
          },
        );
      },
    );
  }
}
