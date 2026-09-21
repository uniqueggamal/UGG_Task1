import 'package:internship_task/features/user/models/academic_qualification_model.dart';
import 'package:internship_task/features/user/models/achievement_model.dart';
import 'package:internship_task/features/user/models/coursework_model.dart';
import 'package:internship_task/features/user/models/experience_model.dart';
import 'package:internship_task/features/user/models/interest_model.dart';
import 'package:internship_task/features/user/models/project_model.dart';
import 'package:internship_task/features/user/models/skill_model.dart';
import 'package:internship_task/features/user/models/user_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';

class FullProfileModel {
  final UserModel user;
  final UserProfileModel? profile;

  final List<AcademicQualificationModel> academicQualifications;
  final List<ExperienceModel> experiences;
  final List<SkillModel> skills;
  final List<ProjectModel> projects;
  final List<AchievementModel> achievements;
  final List<CourseworkModel> courseworks;
  final List<InterestModel> interests;

  const FullProfileModel({
    required this.user,
    this.profile,
    this.academicQualifications = const [],
    this.experiences = const [],
    this.skills = const [],
    this.projects = const [],
    this.achievements = const [],
    this.courseworks = const [],
    this.interests = const [],
  });

  factory FullProfileModel.fromJson(Map<String, dynamic> json) {
    return FullProfileModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),

      profile: json['profile'] != null
          ? UserProfileModel.fromJson(json['profile'] as Map<String, dynamic>)
          : null,

      academicQualifications:
          (json['academic_qualifications'] as List<dynamic>?)
              ?.map(
                (item) => AcademicQualificationModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],

      experiences:
          (json['experiences'] as List<dynamic>?)
              ?.map(
                (item) =>
                    ExperienceModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],

      skills:
          (json['skills'] as List<dynamic>?)
              ?.map((item) => SkillModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],

      projects:
          (json['projects'] as List<dynamic>?)
              ?.map(
                (item) => ProjectModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],

      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map(
                (item) =>
                    AchievementModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],

      courseworks:
          (json['courseworks'] as List<dynamic>?)
              ?.map(
                (item) =>
                    CourseworkModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],

      interests:
          (json['interests'] as List<dynamic>?)
              ?.map(
                (item) => InterestModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}
