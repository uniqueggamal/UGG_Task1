class AchievementModel {
  final int id;
  final int userId;
  final String title;
  final String? description;
  final String? date;

  const AchievementModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.date,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: json['date'] as String?,
    );
  }
}