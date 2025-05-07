import 'package:flutter/material.dart';
import 'package:sound_mp3/data/data_local/secure_storage_helper.dart';
import 'package:sound_mp3/data/models/users.dart';
import 'package:sound_mp3/data/responses/api_response.dart';

import 'package:sound_mp3/services/users_service.dart';
import 'package:sound_mp3/utils/app_strings.dart';

class UsersViewmodel with ChangeNotifier {
  final UsersService _usersService = UsersService();

  // getter setter
  ApiResponse<Users> _user = ApiResponse.loading();
  ApiResponse<Users> get user => _user;

  // lay user
  Future<void> getUser() async {
    _user = ApiResponse.loading();
    notifyListeners();

    try {
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Get user fail");
      }
      final user = await _usersService.getUser(accessToken);
      _user = ApiResponse.completed(user);
    } catch (error) {
      _user = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }

}
