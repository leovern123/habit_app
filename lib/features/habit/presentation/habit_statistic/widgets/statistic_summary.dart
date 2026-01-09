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


  }
}
