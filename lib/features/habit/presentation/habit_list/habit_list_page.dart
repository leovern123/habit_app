import 'package:flutter/material.dart';
import 'widgets/confirm_delete_dialog.dart';
import 'widgets/edit_habit_bottom_sheet.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';
import 'package:uas_flutter/features/habit/model/habit_model.dart';
import 'package:uas_flutter/features/habit/presentation/habit_list/habit_list_filter.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit List'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Column(
        children: [
          // Filter SegmentedButton
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<HabitFilter>(
              segments: const [
                ButtonSegment(
                  value: HabitFilter.all,
                  label: Text('Semua'),
                  icon: Icon(Icons.list),
                ),
                ButtonSegment(
                  value: HabitFilter.active,
                  label: Text('Aktif'),
                  icon: Icon(Icons.check_circle),
                ),
                ButtonSegment(
                  value: HabitFilter.inactive,
                  label: Text('Nonaktif'),
                  icon: Icon(Icons.pause_circle),
                ),
              ],
              selected: {_filter},
              onSelectionChanged: (value) {
                setState(() {
                  _filter = value.first;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.green.shade600;
                  }
                  return Colors.green.shade50;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return Colors.green.shade700;
                }),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // List of Habits
          Expanded(
            child: StreamBuilder<List<Habit>>(
              stream: habitService.getAllHabits(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const HabitListEmpty();
                }

                // Apply filter
                final habits = snapshot.data!.where((habit) {
                  switch (_filter) {
                    case HabitFilter.active:
                      return habit.isActive;
                    case HabitFilter.inactive:
                      return !habit.isActive;
                    case HabitFilter.all:
                      return true;
                  }
                }).toList();

                if (habits.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada habit sesuai filter'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: habits.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final habit = habits[index];

                    return HabitListItem(
                      habitId: habit.habitId,
                      habitTime: habit.habitTime?.toDate() ?? DateTime.now(), 
                      title: habit.title,
                      isActive: habit.isActive,
                      notificationOn: habit.notificationOn ?? true, // default ON
                      onToggleNotification: () async {
                        await habitService.toggleNotification(habit);
                      },
                      onToggleActive: () async {
                        await habitService.toggleActive(habit.habitId, habit.isActive);
                      },
                      onDelete: () async {
                        final confirm = await showConfirmDeleteDialog(context);
                        if (confirm == true) {
                          await habitService.deleteHabit(habit.habitId);
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
          ),
        ],
      ),
    );
    
  }
}
