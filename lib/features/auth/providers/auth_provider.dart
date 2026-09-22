import 'package:flutter/foundation.dart';

import 'package:internship_task/core/storage/preference_storage.dart';
import 'package:internship_task/features/auth/models/login_request.dart';
import 'package:internship_task/features/auth/models/register_model.dart';
import 'package:internship_task/features/auth/services/auth_service.dart';
import 'package:internship_task/features/auth/services/notification_services.dart';
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
  final NotificationService _notificationService = NotificationService();

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

    // Register FCM token after successful authentication.
    await _registerFcmToken();
  }

  // =========================
  // REGISTER FCM TOKEN
  // =========================

  Future<void> _registerFcmToken() async {
    // Cannot register an FCM token without
    // an authenticated Laravel user.
    if (_token == null || _token!.isEmpty) {
      return;
    }

    try {
      final fcmToken = await _notificationService.getFcmToken();

      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint('FCM token is unavailable.');
        return;
      }

      await _notificationService.registerFcmToken(
        fcmToken: fcmToken,
        sanctumToken: _token!,
      );

      debugPrint('FCM token registered with Laravel.');
    } catch (e) {
      // FCM registration failure should not make
      // an otherwise successful login fail.
      debugPrint('Failed to register FCM token: $e');
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
      debugPrint('Stored auth token after logout: $storedToken');

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

      // No token stored → user is not logged in.
      if (storedToken == null || storedToken.isEmpty) {
        _authState = false;
        _token = null;
        _user = null;
        return;
      }

      // Token exists → verify it with Laravel.
      final userService = UserService();
      final user = await userService.getUser(storedToken);

      // Laravel accepted the stored Sanctum token.
      _token = storedToken;
      _user = user;
      _authState = true;

      // Session is valid, so register the current
      // FCM token as well.
      await _registerFcmToken();
    } catch (_) {
      // Token is invalid/revoked or request failed.
      await _storage.clearAuth();

      _token = null;
      _user = null;
      _authState = false;
    } finally {
      _isCheckingAuth = false;
      notifyListeners();
    }
  }

  // =========================
  // REGISTER USER
  // =========================

  Future<void> registerUser(RegisterRequest model) async {
    final data = await _authService.register(model: model);

    if (data['token'] == null) {
      throw _AuthException('Registration failed.');
    }
  }
}
