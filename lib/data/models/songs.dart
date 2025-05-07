import 'package:cloud_firestore/cloud_firestore.dart';

class Songs {
  String? id;
  String title;
  String source;
  String? image;
  int duration;
  String? album;
  int? interested;
  List<String> artist;
  String? releaseDate;

  Songs({
    this.id,
    required this.title,
    required this.source,
    this.image,
    required this.duration,
    this.album,
    this.interested,
    required this.artist,
    this.releaseDate,
  });

  factory Songs.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Songs(
      id: snapshot.id,
      title: data?['title'],
      source: data?['source'],
      image: data?['image'],
      duration: data?['duration'],
      album: data?['album'],
      interested: data?['likeCount'],
      artist: List<String>.from(data?['artist'] ?? []),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "source": source,
      "image": image ?? "",
      "duration": duration,
      "album": album ?? "Single",
      "likeCount": interested ?? 0,
      "artist": artist,
    };
  }

  factory Songs.fromJson(Map<String, dynamic> json) {
    return Songs(
      id: json["_id"],
      title: json['title'],
      source: json['source'],
      image: json['image'],
      duration: json['duration'],
      album: json['album'],
      interested: json['interested'],
      artist: List<String>.from(json['artists']),
      releaseDate: json['releaseDate'],
    );
  }
}
