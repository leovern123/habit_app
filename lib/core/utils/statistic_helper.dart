class HabitStat {
  final int success;
  final int total;

  HabitStat(this.success, this.total);

  double get percent => total == 0 ? 0 : success / total;
}

HabitStat calculateStat(List<dynamic> logs) {
  final total = logs.length;
  final success = logs.where((e) => e['isDone'] == true).length;
  return HabitStat(success, total);
}
