import 'package:flutter/foundation.dart';

import 'package:internship_task/core/storage/preference_storage.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final PreferencesService _storage = PreferencesService();

  bool _authState = false;
  String? _token;
  Map<String, dynamic>? _user;

  bool _isLoading = false;
  bool _isCheckingAuth = true;

  bool get authState => _authState;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  bool get isLoading => _isLoading;
  bool get isCheckingAuth => _isCheckingAuth;

  // =========================
  // LOGIN
  // =========================

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _authService.login(email: email, password: password);

      if (data == null || data['token'] == null) {
        throw AuthException('Login failed.');
      }

      _token = data['token'];

      await _storage.saveAuth(token: _token!);

      print('token: $_token');

      _authState = true;

      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

      // No stored token
      if (storedToken == null || storedToken.isEmpty) {
        _authState = false;
        return;
      }

      if (storedToken != null) {
        _authState = true;
        return;
      }

      // Check token against Laravel
      // final user = await _authService.getUser(storedToken);

      // if (user != null) {
      //   _token = storedToken;
      //   _user = user;
      //   _authState = true;
      // } else {
      //   await _storage.clearAuth();

      //   _token = null;
      //   _user = null;
      //   _authState = false;
      // }
    } catch (_) {
      await _storage.clearAuth();

      _token = null;
      _user = null;
      _authState = false;
    } finally {
      _isCheckingAuth = false;
      notifyListeners();
    }
  }
}
