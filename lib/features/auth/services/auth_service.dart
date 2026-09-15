import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://192.168.0.122:8000/api';

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('\nLogin status: ${response.statusCode}\n');
      print('\nLogin response: ${response.body}\n');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('\nToken received: ${data['token']}');
        return data;
      }

      return null;
    } catch (e) {
      print('\nLogin error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('\nUser status: ${response.statusCode}');
      print('\nAuthenticated user: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('Get user error: $e');
      return null;
    }
  }

  Future<bool> logout(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('\nLogout status: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('\nLogout error: $e');
      return false;
    }
  }
}
