import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/utils/api_endpoints.dart';
import 'package:sound_mp3/utils/app_config.dart';
import 'package:sound_mp3/utils/constants.dart';

class ArtistsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // lay tat ca artist
  Future<List<Artists>> getAllArtists(String accessToken) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}${ApiEndpoints.getAllArtist}'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      final errorJson = jsonDecode(response.body);
      throw Exception(errorJson['message'] ?? 'failed');
    }

    List<Artists> artists = [];
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    final List<dynamic> artistListJson = jsonResponse['data'];
    artists = artistListJson.map((json) => Artists.fromJson(json)).toList();

    return artists;
  }

  // lay nghe si theo id
  Future<Artists> getArtistById(String artistId) async {
    final querySnapshot = await _db
        .collection(AppConstants.ARTISTS_COLLECTION)
        .doc(artistId)
        .get();
    return Artists.fromFirestore(querySnapshot);
  }
}
