import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? uid;
  String name;
  String email;
  String? avatar;
  String? createdAt;
  List<String>? likedArtists;
  List<String>? likedSongs;
  bool? premium;

  Users({
    this.uid,
    required this.email,
    this.avatar,
    this.createdAt,
    this.likedArtists,
    this.likedSongs,
    this.premium = false,
    required this.name,
  });

  factory Users.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Users(
      uid: snapshot.id,
      email: data?['email'],
      avatar: data?['avatar'],
      createdAt: data?['createdAt'],
      likedArtists: data?['likedArtists'],
      likedSongs: data?['likedSongs'],
      premium: data?['premium'] ?? false,
      name: data?['name'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "email": email,
      "avatar": avatar ?? "",
      "createdAt": createdAt ?? "",
      "likedArtists": likedArtists ?? [],
      "likedSongs": likedSongs ?? [],
      "premium": premium ?? false,
      "name": name,
    };
  }
}
