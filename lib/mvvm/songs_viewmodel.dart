import 'package:flutter/material.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/firestore/artists_service.dart';
import 'package:sound_mp3/services/firestore/songs_service.dart';

class SongsViewmodel with ChangeNotifier {
  final SongsService _songsService = SongsService();
  final ArtistsService _artistsService = ArtistsService();

  // getter setter all song
  ApiResponse<List<Songs>> _songs = ApiResponse.loading();
  ApiResponse<List<Songs>> get songs => _songs;

  // getter setter get song by artist id
  ApiResponse<List<Songs>> _songsByArtistId = ApiResponse.loading();
  ApiResponse<List<Songs>> get songsByArtistId => _songsByArtistId;

  // getter setter get song by album id
  ApiResponse<List<Songs>> _songsByAlbumId = ApiResponse.loading();
  ApiResponse<List<Songs>> get songsByAlbumId => _songsByAlbumId;

  // lay tat ca song
  Future<void> getAllSongs() async {
    _songs = ApiResponse.loading();
    notifyListeners();

    try {
      final songsWithArtistId = await _songsService.getAllSongs();
      final songsWithArtistNames =
          await _convertArtistIdsToNames(songsWithArtistId);

      _songs = ApiResponse.completed(songsWithArtistNames);
    } catch (error) {
      _songs = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }

  // lay song theo artists id
  Future<void> getSongsByArtistId(String artId) async {
    _songsByArtistId = ApiResponse.loading();
    notifyListeners();

    try {
      final songsWithArtistId = await _songsService.getSongsByArtistId(artId);
      final songsWithArtistNames =
          await _convertArtistIdsToNames(songsWithArtistId);

      _songsByArtistId = ApiResponse.completed(songsWithArtistNames);
    } catch (error) {
      _songsByArtistId = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }

  // lay song theo album id
  Future<void> getSongsByAlbumId(String albumId) async {
    _songsByAlbumId = ApiResponse.loading();
    notifyListeners();

    try {
      final songsWithAlbumId = await _songsService.getSongsByAlbumId(albumId);
      final songsWithArtistNames =
          await _convertArtistIdsToNames(songsWithAlbumId);

      _songsByAlbumId = ApiResponse.completed(songsWithArtistNames);
    } catch (error) {
      _songsByAlbumId = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }


  
  
  //! convert song(artist id) -> song (artist name)
  Future<List<Songs>> _convertArtistIdsToNames(List<Songs> songs) async {
    for (var song in songs) {
      List<String> artistNames = [];
      for (var artistId in song.artist) {
        final artist = await _artistsService.getArtistById(artistId);
        artistNames.add(artist.name);
      }
      song.artist = artistNames;
    }
    return songs;
  }
}
