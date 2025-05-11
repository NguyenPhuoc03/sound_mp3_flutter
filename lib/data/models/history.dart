import 'package:sound_mp3/data/models/songs.dart';

class History {
  final List<Songs> today;
  final List<Songs> yesterday;
  final List<Songs> other;

  History({
    required this.today,
    required this.yesterday,
    required this.other,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      today: List<Songs>.from((json['today']?['simplifiedItems'] ?? [])
          .map((item) => Songs.fromJson(item["song"]))),
      yesterday: List<Songs>.from((json['yesterday']?['simplifiedItems'] ?? [])
          .map((item) => Songs.fromJson(item["song"]))),
      other: List<Songs>.from((json['other']?['simplifiedItems'] ?? [])
          .map((item) => Songs.fromJson(item["song"]))),
    );
  }
}
