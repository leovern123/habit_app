import 'package:flutter/material.dart';

class HabitListEmpty extends StatelessWidget {
  const HabitListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Belum ada habit.\nTambahkan habit dari Dashboard.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}