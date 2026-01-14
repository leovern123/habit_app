import 'package:flutter/material.dart';

enum HabitFilter { all, active, inactive }

class HabitListFilter extends StatelessWidget {
  final HabitFilter selected;
  final ValueChanged<HabitFilter> onChanged;

  const HabitListFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: [
          ChoiceChip(
            label: const Text('Semua'),
            selected: selected == HabitFilter.all,
            onSelected: (_) => onChanged(HabitFilter.all),
          ),
          ChoiceChip(
            label: const Text('Aktif'),
            selected: selected == HabitFilter.active,
            onSelected: (_) => onChanged(HabitFilter.active),
          ),
          ChoiceChip(
            label: const Text('Nonaktif'),
            selected: selected == HabitFilter.inactive,
            onSelected: (_) => onChanged(HabitFilter.inactive),
          ),
        ],
      ),
    );
  }
}
