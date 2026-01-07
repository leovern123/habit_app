import 'package:flutter/material.dart';
import '../../data/habit_service.dart';
import './widgets/habit_home_header.dart';
import './widgets/habit_today_list.dart';
import './widgets/add_habit_bottom_sheet.dart';

class HabitHomePage extends StatelessWidget {
  const HabitHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final habitService = HabitService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Column(
        children: [
             HabitHomeHeader(
            habitService: habitService,),
          Expanded(
            child: HabitTodayList(habitService: habitService),),
        ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => AddHabitBottomSheet(habitService: habitService),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
