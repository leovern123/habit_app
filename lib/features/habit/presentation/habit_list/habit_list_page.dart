import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/confirm_delete_dialog.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';
import 'package:uas_flutter/features/habit/model/habit_model.dart';
import 'package:uas_flutter/features/habit/presentation/habit_list/habit_list_empty.dart';
import 'package:uas_flutter/features/habit/presentation/habit_list/habit_list_item.dart';


class HabitListPage extends StatelessWidget {
  const HabitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final habitService = HabitService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit List'),
      ),
      body: StreamBuilder<List<Habit>>(
      stream: habitService.getHabits(),
                 builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const HabitListEmpty();
          }

          final habits = snapshot.data!;


         return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final habit = habits[index];

              return HabitListItem(
                title: habit.title,
                isActive: habit.isActive,
                onToggleActive: () async {
                  await FirebaseFirestore.instance
                      .collection('habits')
                      .doc(habit.habitId)
                      .update({
                    'isActive': !habit.isActive,
                  });
                },
                onDelete: () async {
                final confirm = await showConfirmDeleteDialog(context);

                  if (confirm == true) {
                    await FirebaseFirestore.instance
                        .collection('habits')
                        .doc(habit.habitId)
                        .delete();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Habit berhasil dihapus')));
                  }
                },
                     onEdit: () {
                 
                },
              );
            },
          );
        },
      ),
    );
  }
}