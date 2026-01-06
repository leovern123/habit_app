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
  TimeOfDay? _selectedTime;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.habit.title);

    if (widget.habit.habitTime != null) {
      final dt = widget.habit.habitTime!.toDate();
      _selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) return;

    setState(() => _isSaving = true);

  final Map<String, dynamic> data = {
  'title': _titleController.text.trim(),
};

    if (_selectedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      data['habitTime'] = Timestamp.fromDate(dateTime);
    }

    await FirebaseFirestore.instance
        .collection('habits')
        .doc(widget.habit.habitId)
        .update(data);

    if (mounted) Navigator.pop(context);
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

          OutlinedButton.icon(
            onPressed: _pickTime,
            icon: const Icon(Icons.access_time),
            label: Text(
              _selectedTime == null
                  ? 'Pilih Jam Habit'
                  : 'Jam: ${_selectedTime!.format(context)}',
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const CircularProgressIndicator()
                : const Text('Simpan Perubahan'),
          ),
        ],
      ),
    );
  }
}
