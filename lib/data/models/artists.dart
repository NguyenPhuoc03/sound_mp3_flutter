import 'package:cloud_firestore/cloud_firestore.dart';

class Artists {
  String? id;
  String name;
  String? avatar;
  int? interested;

  Artists({
    this.id,
    required this.name,
    this.avatar,
    this.interested,
  });

  factory Artists.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Artists(
      id: snapshot.id,
      name: data?['name'],
      avatar: data?['avatar'],
      interested: data?['interested'],
    );
  }
  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(
      id: json["_id"],
      name: json['name'],
      avatar: json['avatar'],
      interested: json['interested'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "avatar": avatar ?? "",
      "interested": interested ?? "",
    };
  }
}
