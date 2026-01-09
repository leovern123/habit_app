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