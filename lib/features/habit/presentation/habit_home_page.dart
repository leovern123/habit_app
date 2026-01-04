import 'package:flutter/material.dart';
import '../data/habit_service.dart';
import '../model/habit_model.dart';


class HabitHomePage extends StatelessWidget {
  const HabitHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HabitService _service = HabitService();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('My Habits'),
        backgroundColor: Colors.blue[400],
      ),
      body: StreamBuilder<List<Habit>>(
        stream: _service.getHabits(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi error: ${snapshot.error}'));
          }
          final habits = snapshot.data ?? [];
          if (habits.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada habit.\nTekan tombol + untuk menambahkan.',
                textAlign: TextAlign.center,
              ),
            );
          }
        }
      ),
    );
  }
}
