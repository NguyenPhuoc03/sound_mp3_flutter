import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/utils/constants.dart';

class FavoriteTransactionServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> likeSong(String userId, String songId) async {
    final userRef = _db.collection(AppConstants.USERS_COLLECTION).doc(userId);
    final songRef = _db.collection(AppConstants.SONGS_COLLECTION).doc(songId);

    try {
      await _db.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> songSnapshot =
            await transaction.get(songRef);
        if (!songSnapshot.exists) {
          throw Exception("Song not exists!");
        }

        // FieldValue.arrayUnion: update vao mang khong bi trung lap
        transaction.update(userRef, {
          "likedSongs": FieldValue.arrayUnion([songId])
        });

        // tang like
        transaction.update(songRef,
            {"likeCount": (songSnapshot.data()!['likeCount'] ?? 0) + 1});
      });

      print("Liked song successfully!");
    } catch (e) {
      print("Error in likeSong transaction: $e");
    }
  }

  Future<void> unlikeSong(String userId, String songId) async {
    final userRef = _db.collection(AppConstants.USERS_COLLECTION).doc(userId);
    final songRef = _db.collection(AppConstants.SONGS_COLLECTION).doc(songId);

    try {
      await _db.runTransaction((transaction) async {
        // Lấy dữ liệu hiện tại của bài hát
        DocumentSnapshot<Map<String, dynamic>> songSnapshot =
            await transaction.get(songRef);
        if (!songSnapshot.exists) {
          throw Exception("Bài hát không tồn tại!");
        }

        // Xóa bài hát khỏi danh sách likedSongs của user
        transaction.update(userRef, {
          "likedSongs": FieldValue.arrayRemove([songId])
        });

        // Giảm số lượt thích của bài hát, nhưng không để âm
        int currentLikes = songSnapshot.data()?['likeCount'] ?? 0;
        transaction.update(
            songRef, {"likeCount": currentLikes > 0 ? currentLikes - 1 : 0});
      });

      print("Unliked song successfully!");
    } catch (e) {
      print("Error in unlikeSong transaction: $e");
    }
  }
}
