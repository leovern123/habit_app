import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/habit_service.dart';

class StatisticSummary extends StatelessWidget {
  final HabitService habitService;
  final DateTimeRange? range;

  const StatisticSummary({
    super.key,
    required this.habitService,
    required this.range,
  });