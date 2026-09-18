class AcademicQualificationModel {
  final int id;
  final int userId;
  final String degree;
  final String institution;
  final String? field;
  final String? startDate;
  final String? endDate;

  const AcademicQualificationModel({
    required this.id,
    required this.userId,
    required this.degree,
    required this.institution,
    this.field,
    this.startDate,
    this.endDate,
  });

  factory AcademicQualificationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AcademicQualificationModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      field: json['field'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );
  }
}