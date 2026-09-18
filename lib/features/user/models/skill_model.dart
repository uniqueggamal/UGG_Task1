class SkillModel {
  final int id;
  final int userId;
  final String name;

  const SkillModel({
    required this.id,
    required this.userId,
    required this.name,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
    );
  }
}