import 'package:flutter/material.dart';
import 'package:sound_mp3/data/responses/basic_user.dart';
import 'package:sound_mp3/services/auth_service.dart';
import 'package:sound_mp3/utils/app_strings.dart';
import 'package:sound_mp3/data/data_local/secure_storage_helper.dart';

class AuthViewmodel with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BasicUser? _currentUser;
  BasicUser? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.login(email, password);
      if (result.accessToken.isEmpty) {
        throw Exception('Invalid access token');
      }
      print(result.user);

      SecureStorageHelper.writeKey(AppStrings.accessToken, result.accessToken);
      _currentUser = result.user;
      notifyListeners();
    } catch (e) {
      print("Login error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.register(name, email, password);

      _isLoading = false;
      notifyListeners();

      return result;
    } catch (e) {
      print("Registration error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorageHelper.deleteKey(AppStrings.accessToken);
    _currentUser = null;
    notifyListeners();
  }
}
