import 'package:flutter/material.dart';
import '../../../../../core/utils/date_helper.dart';

class HabitHomeHeader extends StatelessWidget {
  const HabitHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateHelper.formattedToday();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hari ini',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            today,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
