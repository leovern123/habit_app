class HabitModel {
  final String id;
  final String title;

  HabitModel({
    required this.id,
    required this.title,
  });

  factory HabitModel.fromFirestore(Map<String, dynamic> data, String id) {
    return HabitModel(
      id: id,
      title: data['title'],
    );
  }
}
