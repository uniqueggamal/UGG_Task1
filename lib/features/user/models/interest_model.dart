class InterestModel {
  final int id;
  final int userId;
  final String name;

  const InterestModel({
    required this.id,
    required this.userId,
    required this.name,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
    );
  }
}
