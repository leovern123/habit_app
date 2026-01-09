import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';

class StatisticHabitList extends StatelessWidget {
  final HabitService habitService;
  final DateTimeRange range;

  const StatisticHabitList({
    super.key,
    required this.habitService,
    required this.range,
  });