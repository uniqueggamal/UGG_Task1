import 'dart:convert';
import 'dart:io';

import 'package:internship_task/core/constants/app_endpoints.dart';
import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/models/user_model.dart';
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
  // ==========================================================
  // CURRENT USER
  // ==========================================================

  // ----------------------------------------------------------
  // GET CURRENT USER
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> getUser(String token) async {
    return _request(method: 'GET', url: ApiEndpoints.user, token: token);
  }

  // ----------------------------------------------------------
  // UPDATE CURRENT USER
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateUser({
    required String token,
    required UserModel user,
  }) async {
    return _request(
      method: 'PUT',
      url: ApiEndpoints.user,
      token: token,
      body: {'name': user.name},
    );
  }

  // ==========================================================
  // FULL PROFILE
  // ==========================================================

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
    required UserProfileModel profile,
  }) async {
    return _request(
      method: 'PUT',
      url: ApiEndpoints.fullProfile,
      token: token,
      body: profile.toJson(),
    );
  }

  // ==========================================================
  // ACADEMIC QUALIFICATIONS
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createAcademicQualification({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.academicQualifications,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateAcademicQualification({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.academicQualifications}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteAcademicQualification({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.academicQualifications}/$id',
      token: token,
    );
  }

  // ==========================================================
  // EXPERIENCES
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createExperience({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.experiences,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateExperience({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.experiences}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteExperience({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.experiences}/$id',
      token: token,
    );
  }

  // ==========================================================
  // SKILLS
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createSkill({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.skills,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateSkill({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.skills}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteSkill({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.skills}/$id',
      token: token,
    );
  }

  // ==========================================================
  // PROJECTS
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createProject({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.projects,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateProject({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.projects}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteProject({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.projects}/$id',
      token: token,
    );
  }

  // ==========================================================
  // ACHIEVEMENTS
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createAchievement({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.achievements,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateAchievement({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.achievements}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteAchievement({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.achievements}/$id',
      token: token,
    );
  }

  // ==========================================================
  // COURSEWORKS
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createCoursework({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.courseworks,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateCoursework({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.courseworks}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteCoursework({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.courseworks}/$id',
      token: token,
    );
  }

  // ==========================================================
  // INTERESTS
  // ==========================================================

  // ----------------------------------------------------------
  // CREATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> createInterest({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'POST',
      url: ApiEndpoints.interests,
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // UPDATE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> updateInterest({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return _request(
      method: 'PUT',
      url: '${ApiEndpoints.interests}/$id',
      token: token,
      body: data,
    );
  }

  // ----------------------------------------------------------
  // DELETE
  // ----------------------------------------------------------

  Future<Map<String, dynamic>> deleteInterest({
    required String token,
    required int id,
  }) async {
    return _request(
      method: 'DELETE',
      url: '${ApiEndpoints.interests}/$id',
      token: token,
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
      // HEADERS
      // --------------------------------------------------------

      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      if (token != null && token.isNotEmpty) {
        request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      }

      if (body != null) {
        request.headers.contentType = ContentType.json;
      }

      // --------------------------------------------------------
      // BODY
      // --------------------------------------------------------

      if (body != null) {
        request.write(jsonEncode(body));
      }

      // --------------------------------------------------------
      // SEND REQUEST
      // --------------------------------------------------------

      final response = await request.close();

      // --------------------------------------------------------
      // READ RESPONSE
      // --------------------------------------------------------

      final responseBody = await response.transform(utf8.decoder).join();

      print('\n$method: $url');
      print('Status: ${response.statusCode}');
      print('Response: $responseBody');

      // --------------------------------------------------------
      // HANDLE RESPONSE
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

      case 'POST':
        return client.postUrl(uri);

      case 'PUT':
        return client.putUrl(uri);

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
      // Some DELETE endpoints may return an empty body.
      if (responseBody.trim().isEmpty) {
        return {'success': true};
      }

      final decoded = jsonDecode(responseBody);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      throw UserException('Invalid response format received from the server.');
    }

    switch (statusCode) {
      case 401:
        throw UserException('Unauthorized. Please login again.');

      case 403:
        throw UserException(
          'You do not have permission to perform this action.',
        );

      case 404:
        throw UserException('The requested resource was not found.');

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
