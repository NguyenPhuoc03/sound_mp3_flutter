import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sound_mp3/utils/constants.dart';

class UsersService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  

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
}
