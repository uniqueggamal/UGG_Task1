class AcademicQualificationModel {
  final int? id;
  final int? userId;
  final String degree;
  final String institution;
  final String? field;
  final String? startDate;
  final String? endDate;

  const AcademicQualificationModel({
    this.id,
    this.userId,
    required this.degree,
    required this.institution,
    this.field,
    this.startDate,
    this.endDate,
  });

  // ============================================================
  // FROM JSON
  // ============================================================

  factory AcademicQualificationModel.fromJson(Map<String, dynamic> json) {
    return AcademicQualificationModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      degree: json['degree'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      field: json['field'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );
  }

  // ============================================================
  // TO JSON
  // ============================================================

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      'degree': degree,
      'institution': institution,
      'field': field,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  // ============================================================
  // COPY WITH
  // ============================================================

  AcademicQualificationModel copyWith({
    int? id,
    int? userId,
    String? degree,
    String? institution,
    String? field,
    String? startDate,
    String? endDate,
  }) {
    return AcademicQualificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      field: field ?? this.field,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
