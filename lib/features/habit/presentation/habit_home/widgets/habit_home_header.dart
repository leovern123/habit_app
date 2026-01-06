import 'package:flutter/material.dart';
import '../../../../../core/utils/date_helper.dart';
import '../../../data/habit_service.dart';
import '../../../model/habit_model.dart';

class HabitHomeHeader extends StatelessWidget {

    final HabitService habitService;

  const HabitHomeHeader({
    super.key,
    required this.habitService,
  });

   Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateHelper.formattedToday(),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 6),

          const Text(
            'Habit Hari Ini',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              ),
          ),
          const SizedBox(height: 20),

          _TodayProgress(habitService: habitService),
        ],
      ),
    );
  }
}

class _TodayProgress extends StatelessWidget {
  final HabitService habitService;

  const _TodayProgress({
    required this.habitService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Habit>>(
      stream: habitService.getHabits(),
      builder: (context, habitSnapshot) {
        if (habitSnapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        if (!habitSnapshot.hasData) {
          return const SizedBox();
        }
        final activeHabits =
            habitSnapshot.data!.where((h) => h.isActive).toList();

        if (activeHabits.isEmpty) {
          return const Text(
            'Belum ada habit aktif',
            style: TextStyle(color: Colors.grey),
          );
        }

        return StreamBuilder<Map<String, bool>>(
          stream: habitService.getTodayLogs(),
          builder: (context, logSnapshot) {
            final logs = logSnapshot.data ?? {};
            final completed = activeHabits
                .where((habit) => logs[habit.habitId] == true)
                .length;

            final total = activeHabits.length;
            final progress = completed / total;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// teks progress
                Text(
                  '$completed dari $total habit selesai',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                /// bar progress
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
