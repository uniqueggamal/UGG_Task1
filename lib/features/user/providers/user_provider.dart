import 'package:flutter/foundation.dart';

import 'package:internship_task/features/user/models/full_profile_model.dart';
import 'package:internship_task/features/user/models/user_model.dart';
import 'package:internship_task/features/user/models/user_profile_model.dart';
import 'package:internship_task/features/user/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  UserProvider({UserService? userService})
    : _userService = userService ?? UserService();

  final UserService _userService;

  FullProfileModel? _fullProfile;

  // ============================================================
  // GETTERS
  // ============================================================

  FullProfileModel? get fullProfile => _fullProfile;

  // ============================================================
  // GET FULL PROFILE
  // ============================================================

  Future<FullProfileModel> getFullProfile(String token) async {
    final profile = await _userService.getFullProfile(token);

    _fullProfile = profile;

    notifyListeners();

    return profile;
  }

  // ============================================================
  // UPDATE USER
  // ============================================================

  Future<Map<String, dynamic>> updateUser({
    required String token,
    required UserModel user,
  }) async {
    final response = await _userService.updateUser(token: token, user: user);

    notifyListeners();

    return response;
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required UserProfileModel profile,
  }) async {
    final response = await _userService.updateProfile(
      token: token,
      profile: profile,
    );

    notifyListeners();

    return response;
  }

  // ============================================================
  // ACADEMIC QUALIFICATIONS
  // ============================================================

  Future<Map<String, dynamic>> createAcademicQualification({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createAcademicQualification(
      token: token,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateAcademicQualification({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateAcademicQualification(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteAcademicQualification({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteAcademicQualification(
      token: token,
      id: id,
    );

    notifyListeners();

    return response;
  }

  // ============================================================
  // EXPERIENCES
  // ============================================================

  Future<Map<String, dynamic>> createExperience({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createExperience(
      token: token,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateExperience({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateExperience(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteExperience({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteExperience(token: token, id: id);

    notifyListeners();

    return response;
  }

  // ============================================================
  // SKILLS
  // ============================================================

  Future<Map<String, dynamic>> createSkill({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createSkill(token: token, data: data);

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateSkill({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateSkill(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteSkill({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteSkill(token: token, id: id);

    notifyListeners();

    return response;
  }

  // ============================================================
  // PROJECTS
  // ============================================================

  Future<Map<String, dynamic>> createProject({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createProject(token: token, data: data);

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateProject({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateProject(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteProject({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteProject(token: token, id: id);

    notifyListeners();

    return response;
  }

  // ============================================================
  // ACHIEVEMENTS
  // ============================================================

  Future<Map<String, dynamic>> createAchievement({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createAchievement(
      token: token,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateAchievement({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateAchievement(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteAchievement({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteAchievement(token: token, id: id);

    notifyListeners();

    return response;
  }

  // ============================================================
  // COURSEWORKS
  // ============================================================

  Future<Map<String, dynamic>> createCoursework({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createCoursework(
      token: token,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateCoursework({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateCoursework(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteCoursework({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteCoursework(token: token, id: id);

    notifyListeners();

    return response;
  }

  // ============================================================
  // INTERESTS
  // ============================================================

  Future<Map<String, dynamic>> createInterest({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.createInterest(
      token: token,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> updateInterest({
    required String token,
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final response = await _userService.updateInterest(
      token: token,
      id: id,
      data: data,
    );

    notifyListeners();

    return response;
  }

  Future<Map<String, dynamic>> deleteInterest({
    required String token,
    required int id,
  }) async {
    final response = await _userService.deleteInterest(token: token, id: id);

    notifyListeners();

    return response;
  }

  // ============================================================
  // CLEAR USER
  // ============================================================

  void clearUser() {
    _fullProfile = null;

    notifyListeners();
  }
}
