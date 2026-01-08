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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary,
            colors.primaryContainer,
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// tanggal
          Text(
            DateHelper.formattedToday(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onPrimary.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 6),

          /// judul
          Text(
            'Habit Hari Ini',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          /// progress card
          _TodayProgress(habitService: habitService),
        ],
      ),
    );
  }
}
