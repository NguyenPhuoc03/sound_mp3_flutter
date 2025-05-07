import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sound_mp3/data/responses/user_login_response.dart';
import 'package:sound_mp3/utils/api_endpoints.dart';
import 'package:sound_mp3/utils/app_config.dart';

class AuthService {
  Future<UserLoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.login}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'Login failed');
    }

    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    return UserLoginResponse.fromJson(jsonResponse);
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.register}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, 'email': email, 'password': password}),
      );

      if (response.statusCode != 201) {
        final errorJson = jsonDecode(response.body);
        throw Exception(errorJson['message'] ?? 'Register failed');
      }
      return true;
    } catch (e) {
      print("Registration failed: $e");
      return false;
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    // xu li logout phía backend (giải phap đưa token vào blacklist)
  }
}
