import 'package:flutter/material.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/firestore/artists_service.dart';
import 'package:sound_mp3/services/firestore/songs_service.dart';

class SongsViewmodel with ChangeNotifier {
  final SongsService _songsService = SongsService();
  final ArtistsService _artistsService = ArtistsService();

  ApiResponse<List<Songs>> _songs = ApiResponse.loading();
  ApiResponse<List<Songs>> get songs => _songs;

  void getAllSongs() async {
    _songs = ApiResponse.loading();
    notifyListeners();

    try {
      final songsWithArtistId = await _songsService.getAllSongs();
      for (var song in songsWithArtistId) {
        List<String> artistNames = [];
        for (var artistId in song.artist) {
          final artist = await _artistsService.getArtistById(artistId);
          artistNames.add(artist.name);
        }
        song.artist = artistNames;
      }

      _songs = ApiResponse.completed(songsWithArtistId);
      print(_songs);
    } catch (error) {
      print("object");
      _songs = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }
}
