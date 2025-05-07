import 'package:flutter/material.dart';
import 'package:sound_mp3/data/data_local/secure_storage_helper.dart';
import 'package:sound_mp3/data/models/albums.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/albums_service.dart';
import 'package:sound_mp3/utils/app_strings.dart';

class AlbumsViewmodel with ChangeNotifier {
  final AlbumsService _albumsService = AlbumsService();

  ApiResponse<List<Albums>> _albums = ApiResponse.loading();
  ApiResponse<List<Albums>> get albums => _albums;

  // lay tat ca album
  Future<void> getAllAlbums() async {
    _albums = ApiResponse.loading();
    notifyListeners();

    try {
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Get all album fail");
      }
      final albumsList = await _albumsService.getAllAlbums(accessToken);

      _albums = ApiResponse.completed(albumsList);
    } catch (error) {
      _albums = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }
}
