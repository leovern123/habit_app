import 'package:flutter/material.dart';
import '../data/habit_service.dart';
import '../model/habit_model.dart';
import 'widgets/stat_card.dart';
import 'widgets/habit_calendar.dart';
import 'widgets/habit_card.dart';
import 'widgets/habit_dialog.dart';

class HabitHomePage extends StatefulWidget {
  const HabitHomePage({super.key});

  @override
  State<HabitHomePage> createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePage> {
  final HabitService _service = HabitService();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('My Habits'),
        backgroundColor: Colors.green[400],
      ),
      body: StreamBuilder<List<Habit>>(
  stream: _service.getHabits(),
  builder: (context, habitSnapshot) {
    if (habitSnapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (habitSnapshot.hasError) {
      return Center(child: Text('Terjadi error: ${habitSnapshot.error}'));
    }
    final habits = habitSnapshot.data ?? [];
     if (habits.isEmpty) return _buildEmptyState();

          return StreamBuilder<Map<String, bool>>(
            stream: _service.getTodayLogs(),
            builder: (context, logSnapshot) {
              final logs = logSnapshot.data ?? {};
              final doneToday = logs.values.where((done) => done).length;
              final longestStreak = habits.fold<int>(0, (prev, habit) {
                final streak = DateTime.now().difference(habit.createdAt.toDate()).inDays + 1;
                return streak > prev ? streak : prev;
              });
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatCard('Total Habit', habits.length.toString(), Colors.green),
                        StatCard('Done Today', doneToday.toString(), Colors.green[700]!),
                      ],
                    ),
                  ),
                  StreamBuilder<Map<String, bool>>(
                    stream: _service.getMonthLogs(),
                    builder: (context, monthSnapshot) {
                      final monthLogs = monthSnapshot.data ?? {};
                      return HabitCalendar(monthLogs);
                    },
                  ),
                  Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: habits.length,
                      itemBuilder: (context, index, animation) {
                        final habit = habits[index];
                        final isDone = logs[habit.habitId] ?? false;

                        return HabitCard(
                          habit: habit,
                          isDone: isDone,
                          animation: animation,
                          onToggle: (done) => _service.toggleHabit(habit.habitId, done),
                          onEdit: () => showDialog(
                            context: context,
                            builder: (_) => HabitDialog(habit: habit),
                          ),
                          onDelete: () => _deleteHabit(context, habit.habitId, index),
                          service: _service,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}


