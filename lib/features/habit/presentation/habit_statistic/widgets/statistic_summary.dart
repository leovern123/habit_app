import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';

class StatisticSummary extends StatelessWidget {
  final HabitService habitService;
  final DateTimeRange? range;

  const StatisticSummary({
    super.key,
    required this.habitService,
    required this.range,
  });

    @override
  Widget build(BuildContext context) {
    if (range == null) {
      return const Text('Pilih rentang tanggal');
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habit_logs')
          .where('userId', isEqualTo: habitService.uid)
          .where('date', isGreaterThanOrEqualTo: range!.start)
          .where('date', isLessThan: range!.end)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final logs = snapshot.data!.docs;
        final total = logs.length;
        final done = logs.where((e) => e['isDone'] == true).length;

         return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Log: $total'),
                const SizedBox(height: 8),
                Text('Selesai: $done'),
                const SizedBox(height: 8),
                Text(
                  'Progress: ${total == 0 ? 0 : ((done / total) * 100).toStringAsFixed(0)}%',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}