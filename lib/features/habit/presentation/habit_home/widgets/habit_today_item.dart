import 'package:flutter/material.dart';
import '../../../model/habit_model.dart';
import '../../../data/habit_service.dart';


class HabitTodayItem extends StatelessWidget {
  final Habit habit;
  final HabitService habitService;

  const HabitTodayItem({
    super.key,
    required this.habit,
    required this.habitService,
  });

  @override
  Widget build(BuildContext context) {
    final habitTime = habit.habitTime?.toDate();
    final timeLabel = habitTime != null
        ? '${habitTime.hour.toString().padLeft(2, '0')}:${habitTime.minute.toString().padLeft(2, '0')}'
        : 'Belum diatur';

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: StreamBuilder<Map<String, bool>>(
          stream: habitService.getTodayLogs(),
          builder: (context, snapshot) {
            final isDone = snapshot.data?[habit.habitId] ?? false;

            return Checkbox(
              value: isDone,
              onChanged: (value) {
                habitService.toggleHabit(
                  habit.habitId,
                  value ?? false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
