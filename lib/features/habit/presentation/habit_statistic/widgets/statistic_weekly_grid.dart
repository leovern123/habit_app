import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/features/habit/data/habit_service.dart';

class StatisticWeeklyGrid extends StatelessWidget {
  final HabitService habitService;

  const StatisticWeeklyGrid({super.key, required this.habitService});