// import 'package:flutter/material.dart';
// import 'package:sound_mp3/services/firestore/favorite_transaction_services.dart';

// class FavoriteViewmodel extends ChangeNotifier {
//   final FavoriteTransactionServices _favoriteService = FavoriteTransactionServices();

//   Future<void> fetchLikedSongs(String userId) async {
//     likedSongs = await _favoriteService.getUserLikedSongs(userId);
//     notifyListeners();
//   }

//   Future<void> likeSong(String userId, String songId) async {
//     await _favoriteService.likeSong(userId, songId);
//     likedSongs.add(songId);
//     notifyListeners();
//   }

//   Future<void> unlikeSong(String userId, String songId) async {
//     await _favoriteService.unlikeSong(userId, songId);
//     likedSongs.remove(songId);
//     notifyListeners();
//   }

//   bool isLiked(String songId) {
//     return likedSongs.contains(songId);
//   }
// }
