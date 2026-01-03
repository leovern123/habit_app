import 'package:flutter/material.dart';

class HabitHomePage extends StatelessWidget {
  const HabitHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: const Center(
        child: Text(
          'Berhasil Login 🎉',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}