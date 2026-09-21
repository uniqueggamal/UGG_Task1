import 'package:flutter/foundation.dart';

import 'package:internship_task/core/storage/preference_storage.dart';
import 'package:internship_task/features/auth/models/login_request.dart';
import 'package:internship_task/features/auth/models/register_model.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';
import 'package:internship_task/features/user/services/user_service.dart';

class _AuthException implements Exception {
  final String message;

  _AuthException(this.message);

  @override
  String toString() => message;
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final PreferencesService _storage = PreferencesService();

  bool _authState = false;
  String? _token;
  Map<String, dynamic>? _user;

  final bool _isLoading = false;
  bool _isCheckingAuth = true;

  bool get authState => _authState;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  bool get isLoading => _isLoading;
  bool get isCheckingAuth => _isCheckingAuth;

  // =========================
  // LOGIN
  // =========================
  Future<void> login({required LoginRequest model}) async {
    final data = await _authService.login(model: model);

    if (data['token'] == null) {
      throw _AuthException('Login failed.');
    }

    _token = data['token'];

    await _storage.saveAuth(token: _token!);

    _authState = true;

    notifyListeners();
  }
  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {
    try {
      if (_token != null) {
        await _authService.logout(_token!);
      }
    } finally {
      _token = null;
      _user = null;
      _authState = false;

      await _storage.clearAuth();
      final storedToken = await _storage.getToken();
      print(storedToken);

      notifyListeners();
    }
  }

  // =========================
  // CHECK AUTH
  // =========================

  Future<void> checkAuth() async {
    _isCheckingAuth = true;
    notifyListeners();

    try {
      final storedToken = await _storage.getToken();

      // No token stored → user is not logged in
      if (storedToken == null || storedToken.isEmpty) {
        _authState = false;
        _token = null;
        _user = null;
        return;
      }

      // Token exists → verify it with Laravel
      final userService = UserService();
      final user = await userService.getUser(storedToken);

      // If getUser() returns successfully, Laravel accepted the token
      _token = storedToken;
      _user = user;
      _authState = true;
    } catch (_) {
      // Token is invalid/revoked or request failed
      await _storage.clearAuth();

      _token = null;
      _user = null;
      _authState = false;
    } finally {
      _isCheckingAuth = false;
      notifyListeners();
    }
  }

  Future<void> registerUser(RegisterRequest model) async {
    final data = await _authService.register(model: model);

    if (data['token'] == null) {
      throw _AuthException('Registration failed.');
    }
  }
}
