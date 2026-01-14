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
    final start =
        DateTime(range.start.year, range.start.month, range.start.day);
    final end =
        DateTime(range.end.year, range.end.month, range.end.day)
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

    /// 🔹 AMBIL SEMUA HABIT (AKTIF + TERHAPUS)
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habits')
          .where('userId', isEqualTo: habitService.uid)
          .snapshots(),
      builder: (context, habitSnap) {
        if (!habitSnap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final habits = habitSnap.data!.docs;

        /// 🔹 AMBIL LOG SESUAI RENTANG
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('habit_logs')
              .where('userId', isEqualTo: habitService.uid)
              .where(
                'dateTs',
                isGreaterThanOrEqualTo: Timestamp.fromDate(start),
              )
              .where(
                'dateTs',
                isLessThan: Timestamp.fromDate(end),
              )
              .snapshots(),
          builder: (context, logSnap) {
            if (!logSnap.hasData) {
              return const SizedBox();
            }

            final logs = logSnap.data!.docs;

            if (logs.isEmpty) {
              return Text(
                emptyText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              );
            }

            /// 🔹 KELOMPOKKAN LOG PER HABIT
            final Map<String, List<QueryDocumentSnapshot>> logsByHabit = {};

            for (final log in logs) {
              final habitId = log['habitId'];
              logsByHabit.putIfAbsent(habitId, () => []).add(log);
            }

            return Column(
              children: logsByHabit.entries.map((entry) {
                final habitId = entry.key;
                final habitLogs = entry.value;

                /// 🔹 CARI HABIT (PASTI ADA NAMANYA)
                final habitList = habits.where((h) => h.id == habitId).toList();

                if (habitList.isEmpty) {
                  return const SizedBox();
                }

                final habit = habitList.first;

                final title = habit['title'];
                final isDeleted = habit['isActive'] == false;

                final done =
                    habitLogs.where((e) => e['isDone'] == true).length;
                final progress = done / habitLogs.length;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isDeleted
                              ? Colors.grey
                              : Colors.black,
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
                        '$done dari ${habitLogs.length} hari',
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
