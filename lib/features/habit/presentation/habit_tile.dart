import 'package:flutter/material.dart';
import '../model/habit_model.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final bool isDone;
  final Function(bool) onChanged;
  final VoidCallback? onDelete; // untuk tombol delete
  final int? streak; // optional untuk streak

  const HabitTile({
    super.key,
    required this.habit,
    required this.isDone,
    required this.onChanged,
    this.onDelete,
    this.streak,
  }); 

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(habit.title),
      value: isDone,
      onChanged: (value) => onChanged(value!),
    );
  }
}
