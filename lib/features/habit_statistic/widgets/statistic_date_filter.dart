import 'package:flutter/material.dart';

class StatisticDateFilter extends StatelessWidget {
  final Function(DateTimeRange) onRangeSelected;

  const StatisticDateFilter({
    super.key,
    required this.onRangeSelected,
  });
