import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/data/models/users.dart';
import 'package:sound_mp3/utils/constants.dart';

class UsersService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lay nguoi dung
  Future<Users?> getUser(String userId) async {
    try {
      final userDoc =
          await _db.collection(AppConstants.USERS_COLLECTION).doc(userId).get();

      if (userDoc.exists) {
        return Users.fromFirestore(userDoc);
      }
      return null;
    } catch (e) {
      print("Error in user services: $e");
      return null;
    }
  }

  // Lay map history song tu user collection
  Future<Map<String, List<String>>> getSongHistory(String userId) async {
    final userDoc =
        await _db.collection(AppConstants.USERS_COLLECTION).doc(userId).get();
    if (userDoc.exists) {
      final data = userDoc.data()!['history'];

      Map<String, List<String>> result = {};
      data.forEach((key, value) {
        result[key] = List<String>.from(value);
      });
      return result;
    }

    return {};
  }

  // Add song history
  Future<void> addSongHistory(String userId, String date, String songId) async {
    try {
      final docRef =
          await _db.collection(AppConstants.USERS_COLLECTION).doc(userId);
      Map<String, List<String>> oldHistory = await getSongHistory(userId);

      if (oldHistory.isEmpty) {
        await docRef.set({
          'history': {
            date: [songId]
          }
        }, SetOptions(merge: true));
      } else {
        // Kiiem tra key co ton tai hay chua
        if (oldHistory.containsKey(date)) {
          // them vao dau danh sach
          if (oldHistory[date]!.isEmpty || oldHistory[date]!.first != songId) {
            oldHistory[date]!.insert(0, songId);
          }
        } else {
          // tao key va them item
          oldHistory[date] = [songId];
        }
        await docRef.update({'history': oldHistory});
      }
      print("Update successful!");
    } catch (e) {
      print("Error in user services: $e");
    }
  }

  // Lay list liked songs tu user collection
  Future<List<String>?> getFavoritedSongs(String userId) async {
    try {
      final userDoc =
          await _db.collection(AppConstants.USERS_COLLECTION).doc(userId).get();
      if (userDoc.exists) {
        List<String> result = List<String>.from(userDoc.data()!['likedSongs']);

        return result;
      }
      return [];
    } catch (e) {
      print("Error in user services: $e");
      return [];
    }
  }

  // Kiem tra bai hat da duoc like chua
  Future<bool> isSongLiked(String userId, String songId) async {
    try {
      List<String>? likedSongs = await getFavoritedSongs(userId);

      if (likedSongs!.isEmpty) return false;
      return likedSongs.contains(songId);
    } catch (e) {
      print("Error checking liked song in user services: $e");
      return false;
    }
  }
}
