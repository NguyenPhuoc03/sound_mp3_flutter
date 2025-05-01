import 'package:sound_mp3/data/models/users.dart';

class UserLoginResponse {
  final String accessToken;
  final Users user;

  UserLoginResponse({
    required this.accessToken,
    required this.user,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      accessToken: json["data"]['accessToken'],
      user: Users.fromJson(json["data"]['user']),
    );
  }
}
