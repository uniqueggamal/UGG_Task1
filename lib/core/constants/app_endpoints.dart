class ApiEndpoints {
  // ==================== Base URL ====================
  static const String baseUrl = 'http://192.168.0.100:8000/api';

  // ==================== Authentication ====================
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
  static const String user = '$baseUrl/user';

  // ==================== Profile ====================
  static const String fullProfile = '$baseUrl/user/profile';

  // ==================== Academic Qualifications ====================
  static const String academicQualifications =
      '$baseUrl/user/academic-qualifications';

  static String academicQualificationById(int id) =>
      '$baseUrl/user/academic-qualifications/$id';

  // ==================== Experiences ====================
  static const String experiences = '$baseUrl/user/experiences';

  static String experienceById(int id) => '$baseUrl/user/experiences/$id';

  // ==================== Skills ====================
  static const String skills = '$baseUrl/user/skills';

  static String skillById(int id) => '$baseUrl/user/skills/$id';

  // ==================== Projects ====================
  static const String projects = '$baseUrl/user/projects';

  static String projectById(int id) => '$baseUrl/user/projects/$id';

  // ==================== Achievements ====================
  static const String achievements = '$baseUrl/user/achievements';

  static String achievementById(int id) => '$baseUrl/user/achievements/$id';

  // ==================== Courseworks ====================
  static const String courseworks = '$baseUrl/user/courseworks';

  static String courseworkById(int id) => '$baseUrl/user/courseworks/$id';

  // ==================== Interests ====================
  static const String interests = '$baseUrl/user/interests';

  static String interestById(int id) => '$baseUrl/user/interests/$id';

  // ==================== Check-Email ====================
  static String checkEmail = '$baseUrl/check-email';

  // ==================== FCM-token ====================
  static String fcmToken = '$baseUrl/fcm-token';
}
