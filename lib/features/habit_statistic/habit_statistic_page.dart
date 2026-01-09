import 'package:flutter/material.dart';
import '../../data/habit_service.dart';
import '../habit_statistic/widgets/statistic_date_filter.dart';
import '../habit_statistic/widgets/statistic_summary.dart';

class HabitStatisticPage extends StatefulWidget {
  const HabitStatisticPage({super.key});

  @override
  State<HabitStatisticPage> createState() => _HabitStatisticPageState();
}

class _HabitStatisticPageState extends State<HabitStatisticPage> {
  final HabitService _habitService = HabitService();

  DateTimeRange? selectedRange;

  void _onDateRangeChanged(DateTimeRange range) {
    setState(() {
      selectedRange = range;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Filter tanggal
            StatisticDateFilter(
              onRangeSelected: _onDateRangeChanged,
            ),

            const SizedBox(height: 16),

            /// Ringkasan statistik
            StatisticSummary(
              habitService: _habitService,
              range: selectedRange,
            ),
          ],
        ),
      ),
    );
  }
}