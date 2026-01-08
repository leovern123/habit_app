import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/confirm_delete_dialog.dart';
import 'widgets/edit_habit_bottom_sheet.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';
import 'package:uas_flutter/features/habit/model/habit_model.dart';
import 'package:uas_flutter/features/habit/presentation/habit_list/habit_list_empty.dart';
import 'package:uas_flutter/features/habit/presentation/habit_list/habit_list_item.dart';


class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  HabitFilter _filter = HabitFilter.all;
  final HabitService habitService = HabitService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Habit List')),
      body: Column(
        children: [
      Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade600,
                  Colors.green.shade400,
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
          child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Habit List',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(height: 4),
      Text(
        'Kelola kebiasaan baikmu setiap hari',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
      ),
    ],
  ),
),
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
                      showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (_) => EditHabitBottomSheet(habit: habit),
                  );                              
                },
              );
            },
          );
        },
      ),
    );
  }
}