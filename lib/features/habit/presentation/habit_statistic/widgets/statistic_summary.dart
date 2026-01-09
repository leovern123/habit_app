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

    final start = DateTime(range!.start.year, range!.start.month, range!.start.day);
    final end = DateTime(range!.end.year, range!.end.month, range!.end.day)
        .add(const Duration(days: 1)); 

    final startText = '${start.day}/${start.month}/${start.year}';
    final endDisplay = end.subtract(const Duration(days: 1));
    final endText = '${endDisplay.day}/${endDisplay.month}/${endDisplay.year}';
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('habit_logs')
          .where('userId', isEqualTo: habitService.uid)
          .where('dateTs', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('dateTs', isLessThan: Timestamp.fromDate(end))
          .snapshots(),
      builder: (context, snapshot) {
      if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final logs = snapshot.data!.docs;
        final total = logs.length;
        final done = logs.where((e) => e['isDone'] == true).length;


        final percent = total == 0 ? 0.0 : done / total;
        final percentText = (percent * 100).toStringAsFixed(0);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 
                Text(
                  'Rentang: $startText - $endText',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),

              Center(
                  child: SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Lingkaran latar (abu-abu)
                        CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 60,
                          valueColor:
                              AlwaysStoppedAnimation(Colors.grey.shade300),
                        ),
                 
                        CircularProgressIndicator(
                          value: percent,
                          strokeWidth: 60,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.green),
                        ),
                      
                        Text(
                          '$percentText%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 16, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                
                Center(
                  child: Text(
                    '$done dari $total habit selesai',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      }