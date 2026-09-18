import 'dart:convert';
import 'dart:io';

import 'package:internship_task/core/constants/app_endpoints.dart';
import 'package:internship_task/features/auth/models/login_request.dart';
import 'package:internship_task/features/auth/models/register_model.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  // =========================
  // COMMON HTTP REQUEST
  // =========================

  Future<Map<String, dynamic>> _post({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final client = HttpClient();

    try {
      final request = await client.postUrl(Uri.parse(url));

      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      if (token != null) {
        request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      }

      if (body != null) {
        request.write(jsonEncode(body));
      }

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      print('\nPOST: $url');
      print('Status: ${response.statusCode}');
      print('Response: $responseBody');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(responseBody);
      }

      if (response.statusCode == 401) {
        throw AuthException('Unauthorized request.');
      }

      if (response.statusCode == 422) {
        throw AuthException('The submitted information is invalid.');
      }

      if (response.statusCode >= 500) {
        throw AuthException('Server error. Please try again later.');
      }

      throw AuthException(
        'Request failed. Status code: ${response.statusCode}',
      );
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException('Unable to connect to the server.');
    } on FormatException {
      throw AuthException('Invalid response received from the server.');
    } finally {
      client.close();
    }
  }

  // =========================
  // LOGIN
  // =========================

  Future<Map<String, dynamic>> login({required LoginRequest model}) async {
    final data = await _post(
      url: ApiEndpoints.login,
      body: {'email': model.email, 'password': model.password},
    );

    if (data['token'] == null) {
      throw AuthException('Login token was not received.');
    }

    return data;
  }

  // =========================
  // CHECK EMAIL
  // =========================

  Future<bool> checkEmail(String email) async {
    final data = await _post(
      url: ApiEndpoints.checkEmail,
      body: {'email': email},
    );

    return data['exists'] == true;
  }

  // =========================
  // REGISTER
  // =========================

  Future<Map<String, dynamic>> register({
    required RegisterRequest model,
  }) async {
    final data = await _post(
      url: ApiEndpoints.register,
      body: {
        'name': model.name,
        'email': model.email,
        'password': model.password,
        'password_confirmation': model.password,
      },
    );

    if (data['token'] == null) {
      throw AuthException('Registration token was not received.');
    }

    return data;
  }

  // =========================
  // LOGOUT
  // =========================

  Future<bool> logout(String token) async {
    await _post(url: ApiEndpoints.logout, token: token);

    return true;
  }
}
