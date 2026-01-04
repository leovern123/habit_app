import 'package:flutter/material.dart';
import '../model/habit_model.dart';
import '../data/habit_service.dart';

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
        : "Tidak ada waktu";

    final createdAtStr =
        "${habit.createdAt.toDate().day}/${habit.createdAt.toDate().month}/${habit.createdAt.toDate().year}";

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    habit.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text('Created: $createdAtStr | Waktu: $habitTimeStr'),
                  leading: GestureDetector(
                    onTap: () => onToggle(!isDone),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: isDone ? Colors.green[700] : Colors.grey[300],
                      child: isDone ? const Icon(Icons.check, color: Colors.white) : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: onEdit,
                  ),
                ),
                const SizedBox(height: 6),
                // Progress bar 7 hari terakhir
                StreamBuilder<List<bool>>(
                  stream: service.getLast7DaysLogs(habit.habitId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator(
                        value: 0,
                        color: Colors.green,
                        backgroundColor: Colors.grey[300],
                        minHeight: 6,
                      );
                    }
                    final last7Days = snapshot.data!;
                    final doneCount = last7Days.where((done) => done).length;
                    final progress = doneCount / 7;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          color: Colors.green[700],
                          backgroundColor: Colors.grey[300],
                          minHeight: 6,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(progress * 100).round()}% minggu ini',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}