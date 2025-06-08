import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/utils/api_endpoints.dart';
import 'package:sound_mp3/utils/app_config.dart';
import 'package:sound_mp3/utils/constants.dart';

class SongsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Songs>> getAllSongs(String accessToken) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.getAllSong}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }

    List<Songs> songs = [];
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> songListJson = jsonResponse['data'];
    songs = songListJson.map((json) => Songs.fromJson(json)).toList();

    return songs;
  }

  // lay bai hat theo artist id
  Future<List<Songs>> getSongsByArtistId(
      String accessToken, String artistId) async {
    final response = await http.get(
      Uri.parse(
          '${AppConfig.baseUrl}${ApiEndpoints.getSongsByArtist(artistId)}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }

    List<Songs> songs = [];
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> songListJson = jsonResponse['data'];
    songs = songListJson.map((json) => Songs.fromJson(json)).toList();

    return songs;
  }

  // lay bai hat theo album id
  Future<List<Songs>> getSongsByAlbumId(
      String accessToken, String albumId) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.getSongsByAlbum(albumId)}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }

    List<Songs> songs = [];
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> songListJson = jsonResponse['data'];
    songs = songListJson.map((json) => Songs.fromJson(json)).toList();

    return songs;
  }

  // kiem tra bai hat da duoc like chua
  Future<bool> isSongLiked(String accessToken, String songId) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.isSongLiked(songId)}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }

    bool isLiked = false;
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    isLiked = jsonResponse['data'];

    return isLiked;
  }

  // like bai hat
  Future<void> likeSong(String accessToken, String songId) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.likeSong(songId)}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'like failed');
    }
  }
  
    // unlike bai hat
  Future<void> unlikeSong(String accessToken, String songId) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.unlikeSong(songId)}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'unlike failed');
    }
  }
  
  // lay bai hat theo search name
  Future<List<Songs>> getSongBySearchName(String searchText) async {
    String endString = searchText + '\uf8ff';
    final querySnapshot = await _db
        .collection(AppConstants.SONGS_COLLECTION)
        .where('title', isGreaterThanOrEqualTo: searchText)
        .where('title', isLessThanOrEqualTo: endString)
        .get();

    List<Songs> songs = [];
    songs = querySnapshot.docs.map((doc) => Songs.fromFirestore(doc)).toList();
    return songs;
  }
}
