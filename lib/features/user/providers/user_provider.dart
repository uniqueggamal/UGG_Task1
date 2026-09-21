import 'package:flutter/foundation.dart';

import 'package:internship_task/features/user/models/full_profile_model.dart';
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

    return _fullProfile!;
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required UserProfileModel model,
  }) async {
    final response = await _userService.updateProfile(
      token: token,
      model: model,
    );

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

