import 'package:flutter/material.dart';
import 'package:sound_mp3/services/firestore/favorite_transaction_services.dart';
import 'package:sound_mp3/utils/app_strings.dart';
import 'package:sound_mp3/utils/shared_prefs_helper.dart';

// like and unlike song using transaction
class FavoriteTransactionViewmodel extends ChangeNotifier {
  final FavoriteTransactionServices _favoriteTransactionServices =
      FavoriteTransactionServices();

  // thay doi trang thai cua like song
  Future<void> toggleFavoritedSong(
      bool isLiked, String songId) async {
    String userId = await SharedPrefsHelper.getUserId(AppStrings.uid);
    if (isLiked) {
      await _favoriteTransactionServices.unlikeSong(userId, songId);
    } else {
      await _favoriteTransactionServices.likeSong(userId, songId);
    }
    notifyListeners();
  }
}
