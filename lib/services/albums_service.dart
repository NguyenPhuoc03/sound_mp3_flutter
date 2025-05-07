import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sound_mp3/data/models/albums.dart';
import 'package:sound_mp3/utils/api_endpoints.dart';
import 'package:sound_mp3/utils/app_config.dart';

class AlbumsService {
  // lay tat ca album
  Future<List<Albums>> getAllAlbums(String accessToken) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.getAllAlbum}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }

    List<Albums> albums = [];
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> albumListJson = jsonResponse['data'];
    albums = albumListJson.map((json) => Albums.fromJson(json)).toList();

    return albums;
  }
}
