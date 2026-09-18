class CourseworkModel {
  final int id;
  final int userId;
  final String name;
  final String? description;

  const CourseworkModel({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
  });

  factory CourseworkModel.fromJson(Map<String, dynamic> json) {
    return CourseworkModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
}