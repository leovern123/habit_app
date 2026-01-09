import 'package:flutter/material.dart';

class StatisticCalendarPicker extends StatelessWidget {
  final Function(DateTimeRange) onSelected;

  const StatisticCalendarPicker({super.key, required this.onSelected});

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );

     if (result != null) {
      onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.calendar_month),
      label: const Text('Pilih Tanggal'),
      onPressed: () => _pick(context),
    );
  }
}
