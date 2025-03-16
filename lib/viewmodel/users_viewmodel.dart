import 'package:flutter/material.dart';
import 'package:sound_mp3/data/models/users.dart';
import 'package:sound_mp3/data/responses/api_response.dart';

import 'package:sound_mp3/services/firestore/users_service.dart';

class UsersViewmodel with ChangeNotifier {
  final UsersService _usersService = UsersService();

  // getter setter
  ApiResponse<Users> _user = ApiResponse.loading();
  ApiResponse<Users> get user => _user;

  // lay user
  Future<void> getUser(String userId) async {
    _user = ApiResponse.loading();
    notifyListeners();

    try {
      final userTemp = await _usersService.getUser(userId);

      _user = ApiResponse.completed(userTemp);
    } catch (error) {
      _user = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }

}
