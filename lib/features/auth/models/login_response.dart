import 'package:internship_task/features/user/models/user_profile_model.dart';

class LoginResponse {
  final String message;
  final UserProfileModel user;
  final String token;

  const LoginResponse({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String? ?? '',
      user: UserProfileModel.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
      token: json['token'] as String? ?? '',
    );
  }
}