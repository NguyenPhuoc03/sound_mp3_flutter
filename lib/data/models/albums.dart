import 'package:cloud_firestore/cloud_firestore.dart';

class Albums {
  String? id;
  String? title;
  String? image;
  String? releaseDate;
  List<String>? artist;

  Albums({
    this.id,
    this.title,
    this.image,
    this.releaseDate,
    this.artist,
  });

  factory Albums.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Albums(
      id: snapshot.id,
      title: data?['title'],
      image: data?['image'],
      releaseDate: data?['releaseDate'],
      artist: data?['artist'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "title": title ?? "",
      "image": image ?? "",
      "releaseDate": releaseDate ?? "",
      "artist": artist ?? [],
    };
  }
}
