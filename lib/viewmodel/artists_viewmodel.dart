import 'package:flutter/material.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/firestore/artists_service.dart';

class ArtistsViewmodel with ChangeNotifier {
  final ArtistsService _artistsService = ArtistsService();

  ApiResponse<List<Artists>> _artists = ApiResponse.loading();
  ApiResponse<List<Artists>> get artists => _artists;

  // lay tat ca artists
  Future<void> getAllArtists() async {
    _artists = ApiResponse.loading();
    notifyListeners();

    try {
      final artistList = await _artistsService.getAllArtists();

      _artists = ApiResponse.completed(artistList);
    } catch (error) {
      print(
          "Error in ArtistsViewmodel: ${ApiResponse.error(error.toString())}");
      _artists = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }
}
