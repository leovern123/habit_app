import 'package:flutter/material.dart';

class HabitCalendar extends StatelessWidget {
  final Map<String, bool> logs;

  const HabitCalendar(this.logs, {super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          final day = index + 1;
          final date = DateTime(now.year, now.month, day);
          final dateStr = "${date.year}-${date.month}-${date.day}";
          final done = logs[dateStr] ?? false;

          Color bgColor;
          if (date.day == now.day) {
            bgColor = Colors.green[700]!;
          } else if (done) {
            bgColor = Colors.green[400]!;
          } else {
            bgColor = Colors.grey[300]!;
          }

          return Container(
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}