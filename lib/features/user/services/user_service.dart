import 'dart:convert';
import 'dart:io';

import 'package:internship_task/core/constants/app_endpoints.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';

// ============================================================
// EXCEPTIONS
// ============================================================

class UserException implements Exception {
  final String message;

  UserException(this.message);

  @override
  String toString() => message;
}

// ============================================================
// USER SERVICE
// ============================================================

class UserService {
  // ----------------------------------------------------------
  // GET CURRENT USER
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> getUser(String token) async {
    return _request(method: 'GET', url: ApiEndpoints.user, token: token);
  }

  // ----------------------------------------------------------
  // GET FULL PROFILE
  // ----------------------------------------------------------

  Future<FullProfileModel> getFullProfile(String token) async {
    final response = await _request(
      method: 'GET',
      url: ApiEndpoints.fullProfile,
      token: token,
    );

    final data = response['data'];

    if (data is! Map<String, dynamic>) {
      throw UserException('Invalid profile data received from the server.');
    }

    return FullProfileModel.fromJson(data);
  }

  // ----------------------------------------------------------
  // UPDATE PROFILE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required UserProfileModel model,
  }) async {
    return _request(
      method: 'PUT',
      url: ApiEndpoints.fullProfile,
      token: token,
      body: model.toJson(),
    );
  }

  // ==========================================================
  // PRIVATE REQUEST HELPER
  // ==========================================================

  Future<Map<String, dynamic>> _request({
    required String method,
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    final client = HttpClient();

    try {
      final request = await _createRequest(
        client: client,
        method: method,
        url: url,
      );

      // --------------------------------------------------------
      // Headers
      // --------------------------------------------------------

      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      if (token != null) {
        request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      }

      if (body != null) {
        request.headers.contentType = ContentType.json;
      }

      // --------------------------------------------------------
      // Body
      // --------------------------------------------------------

      if (body != null) {
        request.write(jsonEncode(body));
      }

      // --------------------------------------------------------
      // Send request
      // --------------------------------------------------------

      final response = await request.close();

      // --------------------------------------------------------
      // Read response
      // --------------------------------------------------------

      final responseBody = await response.transform(utf8.decoder).join();

      print('\n$method: $url');
      print('Status: ${response.statusCode}');
      print('Response: $responseBody');

      // --------------------------------------------------------
      // Handle response
      // --------------------------------------------------------

      return _handleResponse(
        statusCode: response.statusCode,
        responseBody: responseBody,
      );
    } on UserException {
      rethrow;
    } on SocketException {
      throw UserException('Unable to connect to the server.');
    } on FormatException {
      throw UserException('Invalid response received from the server.');
    } finally {
      client.close();
    }
  }

  // ==========================================================
  // CREATE REQUEST
  // ==========================================================

  Future<HttpClientRequest> _createRequest({
    required HttpClient client,
    required String method,
    required String url,
  }) async {
    final uri = Uri.parse(url);

    switch (method) {
      case 'GET':
        return client.getUrl(uri);

      case 'PUT':
        return client.putUrl(uri);

      case 'POST':
        return client.postUrl(uri);

      case 'DELETE':
        return client.deleteUrl(uri);

      default:
        throw UserException('Unsupported HTTP method: $method');
    }
  }

  // ==========================================================
  // HANDLE RESPONSE
  // ==========================================================

  Map<String, dynamic> _handleResponse({
    required int statusCode,
    required String responseBody,
  }) {
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(responseBody) as Map<String, dynamic>;
    }

    switch (statusCode) {
      case 401:
        throw UserException('Unauthorized. Please login again.');

      case 422:
        throw UserException('The submitted information is invalid.');

      default:
        if (statusCode >= 500) {
          throw UserException('Server error. Please try again later.');
        }

        throw UserException('Request failed. Status code: $statusCode');
    }
  }
}
