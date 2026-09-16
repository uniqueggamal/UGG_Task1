import 'dart:convert';
import 'dart:io';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  static const String baseUrl = 'http://192.168.0.122:8000/api';
  

  // =========================
  // LOGIN
  // =========================

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final client = HttpClient();

    try {
      final request = await client.postUrl(
        Uri.parse('$baseUrl/login'),
      );

      request.headers.contentType = ContentType.json;
      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json',
      );

      request.write(
        jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final response = await request.close();
      final responseBody =
          await response.transform(utf8.decoder).join();

      print('\nLogin status: ${response.statusCode}');
      print('\nLogin response: $responseBody');

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);

        print('\nToken received: ${data['token']}');

        return data;
      }

      if (response.statusCode == 401) {
        throw AuthException('Invalid email or password.');
      }

      if (response.statusCode == 422) {
        throw AuthException(
          'The submitted information is invalid.',
        );
      }

      if (response.statusCode >= 500) {
        throw AuthException(
          'Server error. Please try again later.',
        );
      }

      throw AuthException(
        'Login failed. Status code: ${response.statusCode}',
      );
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException(
        'Unable to connect to the server.',
      );
    } on FormatException {
      throw AuthException(
        'Invalid response received from the server.',
      );
    } finally {
      client.close();
    }
  }


  // =========================
  // LOGOUT
  // =========================

  Future<bool> logout(String token) async {
    final client = HttpClient();

    try {
      final request = await client.postUrl(
        Uri.parse('$baseUrl/logout'),
      );

      request.headers.set(
        HttpHeaders.contentTypeHeader,
        'application/json',
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

      print('\nLogout status: ${response.statusCode}');
      print('\nLogout response: $responseBody');

      if (response.statusCode == 200) {
        return true;
      }

      throw AuthException(
        'Logout failed. Status code: ${response.statusCode}',
      );
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException(
        'Unable to connect to the server.',
      );
    } on FormatException {
      throw AuthException(
        'Invalid response received from the server.',
      );
    } finally {
      client.close();
    }
  }
}