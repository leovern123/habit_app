import 'package:flutter/material.dart';
import '../../data/habit_service.dart';
import './widgets/habit_home_header.dart';
import './widgets/habit_today_list.dart';
import './widgets/add_habit_bottom_sheet.dart';

class HabitHomePage extends StatefulWidget {
  const HabitHomePage({super.key});

  @override
  State<HabitHomePage> createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePage> {
  late final HabitService habitService;

  @override
  void initState() {
    super.initState();

    habitService = HabitService();

    // 🔁 Restore semua notifikasi dari Firestore
    habitService.restoreAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          HabitHomeHeader(
            habitService: habitService,
          ),
          Expanded(
            child: HabitTodayList(
              habitService: habitService,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: theme.colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (_) =>
                AddHabitBottomSheet(habitService: habitService),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
