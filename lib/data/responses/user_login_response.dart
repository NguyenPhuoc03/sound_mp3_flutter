import 'package:sound_mp3/data/responses/basic_user.dart';

class UserLoginResponse {
  final String accessToken;
  final BasicUser user;

  UserLoginResponse({
    required this.accessToken,
    required this.user,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      accessToken: json["data"]['accessToken'],
      user: BasicUser.fromJson(json["data"]['user']),
    );
  }
}
