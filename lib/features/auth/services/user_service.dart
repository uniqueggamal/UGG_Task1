import 'dart:convert';
import 'dart:io';

class UserException implements Exception {
  final String message;

  UserException(this.message);

  @override
  String toString() => message;
}

class UserService {
  static const String baseUrl =
      'http://192.168.0.122:8000/api';

  // =========================
  // GET CURRENT USER
  // =========================

  Future<Map<String, dynamic>> getUser(String token) async {
    final client = HttpClient();

    try {
      final request = await client.getUrl(
        Uri.parse('$baseUrl/user'),
      );

      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json',
      );

      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $token',
      );

      final response = await request.close();

      final responseBody =
          await response.transform(utf8.decoder).join();

      print('\nUser status: ${response.statusCode}');
      print('\nUser response: $responseBody');

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      }

      if (response.statusCode == 401) {
        throw UserException(
          'Unauthorized. Please login again.',
        );
      }

      if (response.statusCode >= 500) {
        throw UserException(
          'Server error. Please try again later.',
        );
      }

      throw UserException(
        'Failed to get user. Status code: ${response.statusCode}',
      );
    } on UserException {
      rethrow;
    } on SocketException {
      throw UserException(
        'Unable to connect to the server.',
      );
    } on FormatException {
      throw UserException(
        'Invalid response received from the server.',
      );
    } finally {
      client.close();
    }
  }

  // =========================
  // GET PROFILE
  // =========================

  Future<Map<String, dynamic>> getProfile(String token) async {
    final client = HttpClient();

    try {
      final request = await client.getUrl(
        Uri.parse('$baseUrl/user/profile'),
      );

      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json',
      );

      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $token',
      );

      final response = await request.close();

      final responseBody =
          await response.transform(utf8.decoder).join();

      print('\nProfile status: ${response.statusCode}');
      print('\nProfile response: $responseBody');

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      }

      if (response.statusCode == 401) {
        throw UserException(
          'Unauthorized. Please login again.',
        );
      }

      if (response.statusCode >= 500) {
        throw UserException(
          'Server error. Please try again later.',
        );
      }

      throw UserException(
        'Failed to get profile. Status code: ${response.statusCode}',
      );
    } on UserException {
      rethrow;
    } on SocketException {
      throw UserException(
        'Unable to connect to the server.',
      );
    } on FormatException {
      throw UserException(
        'Invalid response received from the server.',
      );
    } finally {
      client.close();
    }
  }

  // =========================
  // UPDATE PROFILE
  // =========================

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final client = HttpClient();

    try {
      final request = await client.putUrl(
        Uri.parse('$baseUrl/user/profile'),
      );

      request.headers.contentType = ContentType.json;

      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json',
      );

      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $token',
      );

      request.write(jsonEncode(data));

      final response = await request.close();

      final responseBody =
          await response.transform(utf8.decoder).join();

      print('\nUpdate profile status: ${response.statusCode}');
      print('\nUpdate profile response: $responseBody');

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      }

      if (response.statusCode == 401) {
        throw UserException(
          'Unauthorized. Please login again.',
        );
      }

      if (response.statusCode == 422) {
        throw UserException(
          'The submitted information is invalid.',
        );
      }

      if (response.statusCode >= 500) {
        throw UserException(
          'Server error. Please try again later.',
        );
      }

      throw UserException(
        'Failed to update profile. Status code: ${response.statusCode}',
      );
    } on UserException {
      rethrow;
    } on SocketException {
      throw UserException(
        'Unable to connect to the server.',
      );
    } on FormatException {
      throw UserException(
        'Invalid response received from the server.',
      );
    } finally {
      client.close();
    }
  }
}