import 'package:cloud_firestore/cloud_firestore.dart';

class Albums {
  String? id;
  String? title;
  String? image;
  String? releaseDate;
  int? interested;
  List<String>? artist;

  Albums({
    this.id,
    this.title,
    this.image,
    this.releaseDate,
    this.interested,
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
      interested: data?['interested'],
      artist: List<String>.from(data?['artist'] ?? []),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "title": title ?? "",
      "image": image ?? "",
      "releaseDate": releaseDate ?? "",
      "interested": interested ?? 0,
      "artist": artist ?? [],
    };
  }

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
      id: json["_id"],
      title: json['title'],
      image: json['image'],
      interested: json['interested'],
      artist: List<String>.from(json['artists']),
      releaseDate: json['releaseDate'],
    );
  }
}
