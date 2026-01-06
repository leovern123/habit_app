import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/habit_model.dart';

class EditHabitBottomSheet extends StatefulWidget {
  final Habit habit;

  const EditHabitBottomSheet({
    super.key,
    required this.habit,
  });

  @override
  State<EditHabitBottomSheet> createState() => _EditHabitBottomSheetState();
}

class _EditHabitBottomSheetState extends State<EditHabitBottomSheet> {
  late TextEditingController _titleController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

     _titleController = TextEditingController(text: widget.habit.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) return;

    setState(() => _isSaving = true);

    await FirebaseFirestore.instance
        .collection('habits')
        .doc(widget.habit.habitId)
        .update({
      'title': _titleController.text.trim(),
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Edit Habit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
           TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Nama Habit',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          