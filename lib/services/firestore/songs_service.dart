import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/services/firestore/users_service.dart';
import 'package:sound_mp3/utils/constants.dart';

class SongsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UsersService _userService = UsersService();

  Future<List<Songs>> getAllSongs() async {
    final querySnapshot =
        await _db.collection(AppConstants.SONGS_COLLECTION).get();

    List<Songs> songs = [];
    songs = querySnapshot.docs.map((doc) {
      return Songs.fromFirestore(doc);
    }).toList();
    return songs;
  }

  // lay bai hat theo artist id
  Future<List<Songs>> getSongsByArtistId(String artistId) async {
    final querySnapshot = await _db
        .collection(AppConstants.SONGS_COLLECTION)
        .where('artist', arrayContains: artistId)
        .get();

    List<Songs> songs = [];
    songs = querySnapshot.docs.map((doc) => Songs.fromFirestore(doc)).toList();
    return songs;
  }

  // lay bai hat theo album id
  Future<List<Songs>> getSongsByAlbumId(String albumId) async {
    final querySnapshot = await _db
        .collection(AppConstants.SONGS_COLLECTION)
        .where('album', isEqualTo: albumId)
        .get();

    List<Songs> songs = [];
    songs = querySnapshot.docs.map((doc) => Songs.fromFirestore(doc)).toList();
    return songs;
  }

  // lay bai hat theo id
  Future<Songs> getSongById(String songId) async {
    final doc =
        await _db.collection(AppConstants.SONGS_COLLECTION).doc(songId).get();
    return Songs.fromFirestore(doc);
  }

  // Lay danh sach lich su bai hat tu user service (Map<date, List<songId>> =>> Map<date, List<Songs>>)
  Future<Map<String, List<Songs>>> getSongHistoryWithDetails(
      String userId) async {
    // Lay lich su tu collection users
    final songHistory = await _userService.getSongHistory(userId);

    // Map can tra ve
    Map<String, List<Songs>> result = {};

    for (String key in songHistory.keys) {
      List<String> songIds = songHistory[key]!;

      List<Songs> songs = await Future.wait(
        songIds.map((id) => getSongById(id)),
      );

      result[key] = songs;
    }
    return result;
  }

 
}
