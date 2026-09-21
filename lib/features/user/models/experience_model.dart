class ExperienceModel {
  final int? id;
  final int? userId;
  final String organization;
  final String position;
  final String? description;
  final String? startDate;
  final String? endDate;
  final bool isCurrent;

  const ExperienceModel({
    this.id,
    this.userId,
    required this.organization,
    required this.position,
    this.description,
    this.startDate,
    this.endDate,
    this.isCurrent = false,
  });

  // ============================================================
  // FROM JSON
  // ============================================================

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      organization: json['organization'] as String? ?? '',
      position: json['position'] as String? ?? '',
      description: json['description'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      isCurrent: json['is_current'] as bool? ?? false,
    );
  }

  // ============================================================
  // TO JSON
  // ============================================================

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      'organization': organization,
      'position': position,
      'description': description,
      'start_date': startDate,
      'end_date': endDate,
      'is_current': isCurrent,
    };
  }

  // ============================================================
  // COPY WITH
  // ============================================================

  ExperienceModel copyWith({
    int? id,
    int? userId,
    String? organization,
    String? position,
    String? description,
    String? startDate,
    String? endDate,
    bool? isCurrent,
  }) {
    return ExperienceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      organization: organization ?? this.organization,
      position: position ?? this.position,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
