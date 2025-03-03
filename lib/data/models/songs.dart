import 'package:cloud_firestore/cloud_firestore.dart';

class Songs {
  String? id;
  String title;
  String source;
  String? image;
  int duration;
  String? album;
  int? likeCount;
  List<String> artist;

  Songs({
    this.id,
    required this.title,
    required this.source,
    this.image,
    required this.duration,
    this.album,
    this.likeCount,
    required this.artist,
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
      likeCount: data?['likeCount'],
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
      "likeCount": likeCount ?? 0,
      "artist": artist,
    };
  }
}
