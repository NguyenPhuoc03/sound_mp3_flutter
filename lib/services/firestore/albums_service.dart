import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/albums.dart';
import 'package:sound_mp3/utils/constants.dart';

class AlbumsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // lay tat ca album
  Future<List<Albums>> getAllAlbums() async {
    final querySnapshot =
        await _db.collection(AppConstants.ALBUMS_COLLECTION).get();

    List<Albums> albums = [];
    albums = querySnapshot.docs.map((doc) {
      return Albums.fromFirestore(doc);
    }).toList();
    return albums;
  }
}
