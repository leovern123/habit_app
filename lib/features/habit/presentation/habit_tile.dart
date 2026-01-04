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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          habit.title,
          style: TextStyle(
            fontSize: 16,
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: streak != null ? HabitStreak(streak: streak!) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isDone,
              activeColor: Colors.blue[400],
              onChanged: (value) => onChanged(value!),
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}