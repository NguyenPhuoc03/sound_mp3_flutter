import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sound_mp3/data/data_local/secure_storage_helper.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/data/responses/api_response.dart';
import 'package:sound_mp3/services/artists_service.dart';
import 'package:sound_mp3/services/songs_service.dart';
import 'package:sound_mp3/utils/app_strings.dart';
import 'package:sound_mp3/utils/shared_prefs.dart';

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

  // getter setter get history song
  ApiResponse<List<Songs>> _todaySongs = ApiResponse.loading();
  ApiResponse<List<Songs>> get todaySongs => _todaySongs;

  ApiResponse<List<Songs>> _yesterdaySongs = ApiResponse.loading();
  ApiResponse<List<Songs>> get yesterdaySongs => _yesterdaySongs;

  ApiResponse<List<Songs>> _pastSongs = ApiResponse.loading();
  ApiResponse<List<Songs>> get pastSongs => _pastSongs;

  // getter setter search song
  ApiResponse<List<Songs>> _searchResults = ApiResponse.loading();
  ApiResponse<List<Songs>> get searchResults => _searchResults;

  // lay tat ca song
  Future<void> getAllSongs() async {
    _songs = ApiResponse.loading();
    notifyListeners();

    try {
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Get all song fail");
      }
      final songs = await _songsService.getAllSongs(accessToken);

      _songs = ApiResponse.completed(songs);
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
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Get song fail");
      }

      final songs = await _songsService.getSongsByArtistId(accessToken, artId);

      _songsByArtistId = ApiResponse.completed(songs);
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
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Get song fail");
      }
      final songs = await _songsService.getSongsByAlbumId(accessToken, albumId);

      _songsByAlbumId = ApiResponse.completed(songs);
    } catch (error) {
      _songsByAlbumId = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }

  // lấy lịch sử nghe nhạc
  Future<void> getHistorySongs() async {
    _todaySongs = ApiResponse.loading();
    _yesterdaySongs = ApiResponse.loading();
    _pastSongs = ApiResponse.loading();
    notifyListeners();

    try {
      String? accessToken =
          await SecureStorageHelper.readValue(AppStrings.accessToken);
      if (accessToken == null) {
        throw Exception("Access token is missing");
      }
      
      final historyData =
          await _songsService.getSongHistoryWithDetails(accessToken);

      final todaySongs = historyData.today;
      final yesterdaySongs = historyData.yesterday;
      final pastSongs = historyData.other;

      _todaySongs = ApiResponse.completed(todaySongs);
      _yesterdaySongs = ApiResponse.completed(yesterdaySongs);
      _pastSongs = ApiResponse.completed(pastSongs);
    } catch (error) {
      _todaySongs = ApiResponse.error(error.toString());
      _yesterdaySongs = ApiResponse.error(error.toString());
      _pastSongs = ApiResponse.error(error.toString());
    } finally {
      notifyListeners();
    }
  }

  // search name
  Future<void> searchSongs(String query) async {
    try {
      List<Songs> list = [];
      if (query.isEmpty) {
        _searchResults = ApiResponse.completed(list);

        print("vsvsv $list");
        notifyListeners();
        return;
      }
      final songsTemp = await _songsService.getSongBySearchName(query);
      list = await _convertArtistIdsToNames(songsTemp);

      _searchResults = ApiResponse.completed(list);
    } catch (error) {
      _searchResults = ApiResponse.error(error.toString());
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
