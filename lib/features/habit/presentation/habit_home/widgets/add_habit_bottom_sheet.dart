import 'package:flutter/material.dart';
import '../../../data/habit_service.dart';

class AddHabitBottomSheet extends StatefulWidget {
  const AddHabitBottomSheet({super.key});

  @override
  State<AddHabitBottomSheet> createState() => _AddHabitBottomSheetState();
}

class _AddHabitBottomSheetState extends State<AddHabitBottomSheet> {
  final _titleController = TextEditingController();
  final HabitService _habitService = HabitService();

  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 0);
  bool _isLoading = false;

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);

    await _habitService.createHabit(
      title: _titleController.text.trim(),
      time: _selectedTime,
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          /// Nama habit
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Nama habit',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

            /// Pilih Jam
          InkWell(
            onTap: _pickTime,
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Jam habit',
                border: OutlineInputBorder(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedTime.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),