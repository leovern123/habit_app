import 'package:flutter/material.dart';
import '../../data/habit_service.dart';
import './widgets/habit_home_header.dart';
import './widgets/habit_today_list.dart';
import './widgets/add_habit_bottom_sheet.dart';

class HabitHomePage extends StatelessWidget {
  const HabitHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final habitService = HabitService();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
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
