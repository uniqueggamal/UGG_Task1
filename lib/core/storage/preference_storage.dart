import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _tokenKey = 'auth_token';
  static const String _authKey = 'is_authenticated';

  Future<void> saveAuth({
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
    await prefs.setBool(_authKey, true);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_authKey) ?? false;
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);
    await prefs.remove(_authKey);
  }
}