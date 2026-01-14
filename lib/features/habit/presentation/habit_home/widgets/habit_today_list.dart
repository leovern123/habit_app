import 'package:flutter/material.dart';
import '../../../data/habit_service.dart';
import '../../../model/habit_model.dart';
import 'habit_today_item.dart';

class HabitTodayList extends StatelessWidget {
  final HabitService habitService;

  const HabitTodayList({
    super.key,
    required this.habitService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Habit>>(
      stream: habitService.getHabits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

       if (snapshot.hasError) {
          return Center(
            child: Text('Terjadi error: ${snapshot.error}'),
          );
        }

        final habits = snapshot.data
                ?.where((h) => h.isActive)
                .toList() ??
            [];

        if (habits.isEmpty) {
          return const Center(
            child: Text('Belum ada habit aktif'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: habits.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return HabitTodayItem(
              habit: habits[index],
              habitService: habitService,
            );
          },
        );
      },
    );
  }
}
