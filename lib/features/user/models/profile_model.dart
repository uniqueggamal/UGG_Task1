class ProfileModel {
  final String name;
  final String? title;
  final String? imagePath;
  final String? description;
  final String? academicQualification;
  final String? technicalSkills;
  final String? projects;
  final String? achievements;
  final String? relevantCoursework;
  final String? interests;
  final String? location;

  const ProfileModel({
    required this.name,
    this.title,
    this.imagePath,
    this.description,
    this.academicQualification,
    this.technicalSkills,
    this.projects,
    this.achievements,
    this.relevantCoursework,
    this.interests,
    this.location,
  });
}
