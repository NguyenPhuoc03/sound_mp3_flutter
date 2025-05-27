import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/users.dart';
import 'package:sound_mp3/utils/api_endpoints.dart';
import 'package:sound_mp3/utils/app_config.dart';
import 'package:sound_mp3/utils/constants.dart';

class UsersService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Users?> getUser(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.profile}'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        throw Exception(errorJson['message'] ?? 'failed');
      }
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      Users users = Users.fromJson(jsonResponse["data"]);
      return users;
    } catch (e) {
      print("Error in user services: $e");
      return null;
    }
  }

  // Lay map history song tu user collection
  Future<Map<String, List<String>>> getSongHistory(String userId) async {
    final userDoc =
        await _db.collection(AppConstants.USERS_COLLECTION).doc(userId).get();
    if (userDoc.exists) {
      final data = userDoc.data()!['history'];

      Map<String, List<String>> result = {};
      data.forEach((key, value) {
        result[key] = List<String>.from(value);
      });
      return result;
    }

    return {};
  }

  // Lay list liked songs tu user collection
  Future<List<String>?> getFavoritedSongs(String userId) async {
    try {
      final userDoc =
          await _db.collection(AppConstants.USERS_COLLECTION).doc(userId).get();
      if (userDoc.exists) {
        List<String> result = List<String>.from(userDoc.data()!['likedSongs']);

        return result;
      }
      return [];
    } catch (e) {
      print("Error in user services: $e");
      return [];
    }
  }

  // Kiem tra bai hat da duoc like chua
  Future<bool> isSongLiked(String userId, String songId) async {
    try {
      List<String>? likedSongs = await getFavoritedSongs(userId);

      if (likedSongs!.isEmpty) return false;
      return likedSongs.contains(songId);
    } catch (e) {
      print("Error checking liked song in user services: $e");
      return false;
    }
  }
}
