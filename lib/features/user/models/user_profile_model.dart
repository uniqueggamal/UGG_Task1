class UserProfileModel {
  final int id;
  final int userId;
  final String? role;
  final String? currentStatus;
  final String? affiliatedOrganization;
  final String? dateOfBirth;
  final String? phone;
  final String? description;
  final String? location;
  final String? profileImage;
  final String? createdAt;
  final String? updatedAt;

  const UserProfileModel({
    required this.id,
    required this.userId,
    this.role,
    this.currentStatus,
    this.affiliatedOrganization,
    this.dateOfBirth,
    this.phone,
    this.description,
    this.location,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      role: json['role'] as String?,
      currentStatus: json['current_status'] as String?,
      affiliatedOrganization: json['affiliated_organization'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      profileImage: json['profile_image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
