// preferences_helper.dart

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUserId = 'userId';
  static const _keyToken = 'token';
  static const _keyName = 'name';
  static const _keyEmail = 'email';
  static const _keyPhotoUrl = 'photoUrl';
  static const _keyUserType = 'userType';
  static const _keyIsRoleJustSelected = 'isRoleJustSelected';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserId(String userId) async =>
      await _preferences.setString(_keyUserId, userId);

  static String? getUserId() => _preferences.getString(_keyUserId);

  static Future setToken(String token) async =>
      await _preferences.setString(_keyToken, token);

  static String? getToken() => _preferences.getString(_keyToken);

  static Future setName(String name) async =>
      await _preferences.setString(_keyName, name);

  static String? getName() => _preferences.getString(_keyName);

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String? getEmail() => _preferences.getString(_keyEmail);

  static Future setPhotoUrl(String photoUrl) async =>
      await _preferences.setString(_keyPhotoUrl, photoUrl);

  static String? getPhotoUrl() => _preferences.getString(_keyPhotoUrl);

  static Future setUserType(String userType) async =>
      await _preferences.setString(_keyUserType, userType);

  static String? getUserType() => _preferences.getString(_keyUserType);

  static Future setIsRoleJustSelected(bool isJustSelected) async =>
      await _preferences.setBool(_keyIsRoleJustSelected, isJustSelected);

  static bool? getIsRoleJustSelected() =>
      _preferences.getBool(_keyIsRoleJustSelected);

  static bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static Future clearPreferences() async {
    await _preferences.clear();
  }
}
