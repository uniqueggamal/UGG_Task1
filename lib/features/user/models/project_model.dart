class ProjectModel {
  final int id;
  final int userId;
  final String title;
  final String? description;
  final String? link;

  const ProjectModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.link,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      link: json['link'] as String?,
    );
  }
}
  