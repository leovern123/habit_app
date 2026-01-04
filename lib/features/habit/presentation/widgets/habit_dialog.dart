import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/habit_model.dart';

class HabitDialog extends StatefulWidget {
  final Habit? habit;
  const HabitDialog({this.habit, super.key});

  @override
  State<HabitDialog> createState() => _HabitDialogState();
}

class _HabitDialogState extends State<HabitDialog> {
  late TextEditingController _controller;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.habit?.title ?? '');
    final habitTime = widget.habit?.habitTime?.toDate();
    _selectedTime = habitTime != null
        ? TimeOfDay(hour: habitTime.hour, minute: habitTime.minute)
        : TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.habit != null;

    return AlertDialog(
      title: Text(isEdit ? 'Edit Habit' : 'Tambah Habit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Nama habit'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 8),
              Text('Jam: ${_selectedTime.format(context)}'),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (picked != null) setState(() => _selectedTime = picked);
                },
                child: const Text('Pilih Waktu'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        ElevatedButton(
          onPressed: _saveHabit,
          child: const Text('Simpan'),
        ),
      ],
    );
  }

  void _saveHabit() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final now = DateTime.now();
    final habitTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (widget.habit == null) {
      // Tambah habit baru
      await FirebaseFirestore.instance.collection('habits').add({
        'title': title,
        'userId': uid,
        'createdAt': Timestamp.fromDate(now),
        'habitTime': Timestamp.fromDate(habitTime),
      });
    } else {
      // Edit habit
      await FirebaseFirestore.instance
          .collection('habits')
          .doc(widget.habit!.habitId)
          .update({
        'title': title,
        'habitTime': Timestamp.fromDate(habitTime),
      });
    }

    if (mounted) Navigator.pop(context);
  }
}