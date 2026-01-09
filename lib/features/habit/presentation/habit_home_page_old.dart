import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/habit_service.dart';
import '../model/habit_model.dart';
import 'widgets/stat_card.dart';
import 'widgets/habit_calendar.dart';
import 'widgets/habit_card.dart';
import 'widgets/habit_dialog.dart';

class HabitHomePageOld extends StatefulWidget {
  const HabitHomePageOld({super.key});

  @override
  State<HabitHomePageOld> createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePageOld> {
  final HabitService _service = HabitService();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

 String _todayLabel() {
  final now = DateTime.now();
  const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
  return '${days[now.weekday % 7]}, '
         '${now.day}/${now.month}/${now.year}';
}

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

          return StreamBuilder<Map<String, bool>>(
            stream: _service.getTodayLogs(),
            builder: (context, logSnapshot) {
              final logs = logSnapshot.data ?? {};
              final doneToday = logs.values.where((done) => done).length;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatCard('Total Habit', habits.length.toString(), Colors.green),
                        StatCard( 'Done Today (${_todayLabel()})', doneToday.toString(),Colors.green[700]!,),
                      ],
                    ),
                  ),
                                // Kalender (satu saja)
                  StreamBuilder<Map<String, bool>>(
                    stream: _service.getCurrentMonthLogsStream('all'), // bisa sesuaikan logikanya
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

                        return Column(
                          children: [
                            HabitCard(
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
                            ),
                          ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[400],
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const HabitDialog(),
        ),
      ),
    );
  }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.self_improvement, size: 100, color: Colors.green[200]),
          const SizedBox(height: 16),
          const Text(
            'Belum ada habit.\nTekan tombol + untuk menambahkan.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
  void _deleteHabit(BuildContext context, String docId, int index) async {
    try {
      await FirebaseFirestore.instance.collection('habits').doc(docId).delete();
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => SizeTransition(sizeFactor: animation, child: Container()),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Habit berhasil dihapus')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menghapus habit: $e')));
    }
  }
}


