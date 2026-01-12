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
      backgroundColor:  Colors.green.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              HabitHomeHeader(
                habitService: habitService,
              ),
              const SizedBox(height: 15), 
              Expanded(
                child: HabitTodayList(
                  habitService: habitService,
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔥 FLOATING BUTTON STACK
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "add_habit",
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
        ],
      ),
    );
  }
}
