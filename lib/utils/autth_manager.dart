import 'package:apple_store/di/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final _sharedpreferences = locator.get<SharedPreferences>();
  static final ValueNotifier<bool> authChangeNotifier = ValueNotifier(
    isLogin(),
  );
  //async
  static void saveToken(String token) async {
    final success = await _sharedpreferences.setString('access_token', token);
    if (success) {
      authChangeNotifier.value = isLogin();
    }
  }

  static String readToken() {
    return _sharedpreferences.getString('access_token') ?? '';
  }

  static void logout() async {
    await _sharedpreferences.remove('access_token');
    authChangeNotifier.value = isLogin();
  }

  static bool isLogin() {
    String token = readToken();
    return token.isNotEmpty;
  }
}
