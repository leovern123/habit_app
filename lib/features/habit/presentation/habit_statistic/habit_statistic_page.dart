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