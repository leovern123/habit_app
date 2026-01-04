import 'package:flutter/material.dart';
import '../data/habit_service.dart';
import '../model/habit_model.dart';
import 'widgets/stat_card.dart';
import 'widgets/habit_calendar.dart';
import 'widgets/habit_card.dart';
import 'widgets/habit_dialog.dart';

class HabitHomePage extends StatefulWidget {
  const HabitHomePage({super.key});

  @override
  State<HabitHomePage> createState() => _HabitHomePageState();
}

class _HabitHomePageState extends State<HabitHomePage> {
  final HabitService _service = HabitService();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('My Habits'),
        backgroundColor: Colors.green[400],
      ),