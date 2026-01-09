import 'package:flutter/material.dart';

class StatisticDateFilter extends StatelessWidget {
  final Function(DateTimeRange) onRangeSelected;

  const StatisticDateFilter({
    super.key,
    required this.onRangeSelected,
  });

 DateTimeRange _today() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    return DateTimeRange(start: start, end: end);
  }
   DateTimeRange _last7Days() {
    final now = DateTime.now();
    return DateTimeRange(
      start: now.subtract(const Duration(days: 6)),
      end: now,
    );
  }
    DateTimeRange _thisMonth() {
    final now = DateTime.now();
    return DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => onRangeSelected(_today()),
            child: const Text('Hari Ini'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            onPressed: () => onRangeSelected(_last7Days()),
            child: const Text('7 Hari'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            onPressed: () => onRangeSelected(_thisMonth()),
            child: const Text('Bulan Ini'),
          ),
        ),
      ],
    );
  }
}