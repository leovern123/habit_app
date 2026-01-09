import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';

class StatisticWeeklyGrid extends StatelessWidget {
  final HabitService habitService;

  const StatisticWeeklyGrid({super.key, required this.habitService});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 6));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habit_logs')
          .where('userId', isEqualTo: habitService.uid)
          .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('dateTs', isLessThanOrEqualTo: Timestamp.fromDate(now))
          .snapshots(),
      builder: (context, snapshot) {
            if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final logs = snapshot.data!.docs;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemBuilder: (context, i) {
            final day = start.add(Duration(days: i));

            final done = logs.any((e) {
              final logDate = (e['dateTs'] as Timestamp).toDate();
              return logDate.year == day.year &&
                  logDate.month == day.month &&
                  logDate.day == day.day &&
                  e['isDone'] == true;
            });
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.day.toString(), // tanggal
                  style: TextStyle(
                    fontSize: 12,
                    color: done ? Colors.green.shade700 : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  done ? Icons.check_circle : Icons.cancel,
                  color: done ? Colors.green : Colors.grey,
                  size: 20,
                ),
              ],
            );
          },
        );
      },
    );
  }
}