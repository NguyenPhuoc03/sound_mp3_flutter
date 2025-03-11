import 'package:flutter/material.dart';
import 'package:sound_mp3/data/models/albums.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/firestore/albums_service.dart';

class AlbumsViewmodel with ChangeNotifier {
  final AlbumsService _albumsService = AlbumsService();

  ApiResponse<List<Albums>> _albums = ApiResponse.loading();
  ApiResponse<List<Albums>> get albums => _albums;

  // lay tat ca album
  Future<void> getAllAlbums() async {
    _albums = ApiResponse.loading();
    notifyListeners();

    try {
      final albumsList = await _albumsService.getAllAlbums();

      _albums = ApiResponse.completed(albumsList);
    } catch (error) {
      _albums = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }
}
