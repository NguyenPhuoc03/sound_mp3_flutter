import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/songs.dart';
import 'package:sound_mp3/utils/constants.dart';

class SongsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Songs>> getAllSongs() async {
    //lay danh sach tu firestore
    final querySnapshot =
        await _db.collection(AppConstants.SONGS_COLLECTION).get();

    List<Songs> songs = [];
    // duyet qua tung bai hat

    songs = querySnapshot.docs.map((doc) {
      return Songs.fromFirestore(doc);
    }).toList();
    return songs;
  }
}
