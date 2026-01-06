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