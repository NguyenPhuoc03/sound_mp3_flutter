import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/utils/constants.dart';

class SongsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
}
