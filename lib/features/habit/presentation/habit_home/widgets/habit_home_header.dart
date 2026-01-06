import 'package:flutter/material.dart';
import '../../../../../core/utils/date_helper.dart';
import '../../../data/habit_service.dart';
import '../../../model/habit_model.dart';

class HabitHomeHeader extends StatelessWidget {

    final HabitService habitService;

  const HabitHomeHeader({
    super.key,
    required this.habitService,
  });

   Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateHelper.formattedToday(),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 6),

          const Text(
            'Habit Hari Ini',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
