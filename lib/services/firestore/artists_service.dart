import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/artists.dart';
import 'package:sound_mp3/utils/constants.dart';

class ArtistsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // lay tat ca artist
  Future<List<Artists>> getAllArtists() async {
    final querySnapshot =
        await _db.collection(AppConstants.ARTISTS_COLLECTION).get();

    List<Artists> artists = [];
    artists = querySnapshot.docs.map((doc) {
      return Artists.fromFirestore(doc);
    }).toList();
    return artists;
  }

  // lay nghe si theo id
  Future<Artists> getArtistById(String artistId) async {
    final querySnapshot = await _db
        .collection(AppConstants.ARTISTS_COLLECTION)
        .doc(artistId)
        .get();
    return Artists.fromFirestore(querySnapshot);
  }
}
