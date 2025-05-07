import 'package:flutter/material.dart';
import 'package:sound_mp3/data/data_local/secure_storage_helper.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/artists_service.dart';
import 'package:sound_mp3/utils/app_strings.dart';

class ArtistsViewmodel with ChangeNotifier {
  final ArtistsService _artistsService = ArtistsService();

  ApiResponse<List<Artists>> _artists = ApiResponse.loading();
  ApiResponse<List<Artists>> get artists => _artists;

  // lay tat ca artists
  Future<void> getAllArtists() async {
    _artists = ApiResponse.loading();
    notifyListeners();

    try {
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Get all artist fail");
      }
      final artistList = await _artistsService.getAllArtists(accessToken);

      _artists = ApiResponse.completed(artistList);
    } catch (error) {
      _artists = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }
}
