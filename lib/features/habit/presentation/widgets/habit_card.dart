import 'package:flutter/material.dart';
import '../../model/habit_model.dart';
import '../../data/habit_service.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final bool isDone;
  final Animation<double> animation;
  final void Function(bool) onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final HabitService service;

  const HabitCard({
    required this.habit,
    required this.isDone,
    required this.animation,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.service,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final habitTime = habit.habitTime?.toDate();
    final habitTimeStr = habitTime != null
        ? "${habitTime.hour.toString().padLeft(2, '0')}:${habitTime.minute.toString().padLeft(2, '0')}"
        : "Belum diatur";

    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: Key(habit.habitId),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => onDelete(),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Toggle habit
                GestureDetector(
                  onTap: () => onToggle(!isDone),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: isDone ? Colors.green[700] : Colors.grey[300],
                    child: isDone ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                ),
                const SizedBox(width: 12),

                // Judul + waktu
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () async {
                          // Buka TimePicker
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: habitTime != null
                                ? TimeOfDay(hour: habitTime.hour, minute: habitTime.minute)
                                : TimeOfDay.now(),
                          );

                          if (picked != null) {
                            // Simpan ke Firestore via service
                            service.updateHabitTime(habit.habitId, picked);
                          }
                        },
                        child: Chip(
                          label: Text('Waktu: $habitTimeStr'),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),

                // Tombol edit
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: onEdit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
