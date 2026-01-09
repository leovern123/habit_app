import 'package:flutter/material.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';
import 'widgets/statistic_date_filter.dart';
import 'widgets/statistic_summary.dart';
import 'widgets/statistic_calendar_picker.dart';
import 'widgets/statistic_weekly_grid.dart';
import 'widgets/statistic_habit_list.dart';

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
    final green = Colors.green.shade700;

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text(
          'Statistik Habit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Tanggal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  StatisticDateFilter(
                    onRangeSelected: _onDateRangeChanged,
                  ),

                  const SizedBox(height: 8),

                   StatisticCalendarPicker(
                    onSelected: _onDateRangeChanged,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (selectedRange != null)
            Card(
              color: Colors.green.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: StatisticSummary(
                  habitService: _habitService,
                  range: selectedRange,
                ),
              ),
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Silakan pilih rentang tanggal untuk melihat statistik',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

          const SizedBox(height: 16),