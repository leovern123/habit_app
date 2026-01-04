import 'package:flutter/material.dart';
import '../model/habit_model.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final bool isDone;
  final Function(bool) onChanged;

  const HabitTile({
    super.key,
    required this.habit,
    required this.isDone,
    required this.onChanged,
  });

  
}
